import os
import re
import sys
import shlex
import subprocess
import sublime
import sublime_plugin

if sys.version_info < (3, 3):
    raise RuntimeError('SimplePHPUnit works with Sublime Text 3 only')

SPU_THEME = 'Packages/SimplePHPUnit/SimplePHPUnit.hidden-tmTheme'
SPU_SYNTAX = 'Packages/SimplePHPUnit/SimplePHPUnit.hidden-tmLanguage'
WINDOW = sublime.active_window()

class NoOpenProjectException(Exception):
    pass

class InvalidFileTypeException(Exception):
    pass

class NoActiveFileException(Exception):
    pass


def verify_open_project():
    try:
        project_root = sublime.active_window().folders()[0]
    except IndexError:
        raise NoOpenProjectException("Command must be run from an open Sublime project")


class pluginShellCommand(sublime_plugin.WindowCommand):
    # Note: this could eventually be generalized into a simple
    #       shell command system

    def run(self, *args, **kwargs):
        try:
            self.execute_command(*args, **kwargs)
        except (IOError, NoOpenProjectException, InvalidFileTypeException, NoActiveFileException) as e:
            sublime.status_message(str(e))

    def execute_command(self, *args, **kwargs):
        self.load_settings()
        self.validate_command_runnable(*args, **kwargs)
        self.run_shell_command(self.generate_command_segments(*args, **kwargs))

    def load_settings(self):
        self.settings = sublime.load_settings('SimplePHPUnit.sublime-settings')

    def validate_command_runnable(self, *args, **kwargs):
        '''throws proper exception if command cannot be executed at present time

        Must be override by subclasses
        '''
        pass

    def generate_command_segments(self, *args, **kwargs):
        '''builds the command segments

        Must be override by subclasses
        '''
        pass

    def run_shell_command(self, command_segments, working_dir=None):
        if os.name != 'posix':
            command_segments = subprocess.list2cmdline(command_segments)

        self.window.run_command("exec", {
            "cmd": command_segments,
            "shell": os.name == 'nt'
        })
        self.show_output_panel()

    def show_output_panel(self, color_scheme_def=None, syntax_def=None):
        if color_scheme_def  is None:
            color_scheme_def = SPU_THEME
        if syntax_def is None:
            syntax_def = SPU_SYNTAX

        panel = self.window.get_output_panel("exec")
        self.window.run_command("show_panel", {"panel": "output.exec"})
        panel.settings().set("color_scheme", SPU_THEME)
        panel.set_syntax_file(SPU_SYNTAX)


class phpunitCommand(pluginShellCommand):
    def validate_command_runnable(self, *args, **kwargs):
        verify_open_project()

    def ensure_open_project(self):
        try:
            project_path = self.window.folders()[0]
        except IndexError:
            raise NoOpenProjectException("PHPUnit must be run from an open Sublime project")

    def generate_command_segments(self, *args, **kwargs):
        return self.generate_base_phpunit_command()

    def generate_base_phpunit_command(self):
        phpunit_executable = self.settings.get('phpunit_executable')
        xml_config_file = self.settings.get('phpunit_xml_config_file')

        command_args = [phpunit_executable, '--stderr']
        if xml_config_file and os.path.isfile(xml_config_file):
            command_args += ['--config', xml_config_file]
        else:
            command_args += [self.window.folders()[0]]

        return command_args


class PhpunitCurrentFileCommand(phpunitCommand):
    def validate_command_runnable(self, *args, **kwargs):
        super(phpunitCommand, self).validate_command_runnable(self, *args, **kwargs)
        self.verify_phpunit_test_file_in_active_view()

    def verify_phpunit_test_file_in_active_view(self):
        current_filename = self.window.active_view().file_name()
        if current_filename is None:
            raise NoActiveFileException('A file must be open in the editor to run PHPUnit on the current file')
        if current_filename.endswith('Test.php') is False:
            raise InvalidFileTypeException('PHPUnit can only be run on PHP files using the naming format "[ClassOrEntityName]Test.php"')

    def is_enabled(self):
        return self.phpunit_test_file_is_in_active_view()

    def phpunit_test_file_is_in_active_view(self):
        try:
            self.verify_phpunit_test_file_in_active_view()
            return True
        except Exception:
            return False

    def generate_command_segments(self, *args, **kwargs):
        return self.generate_base_phpunit_command() + [self.window.active_view().file_name()]


class PhpunitCustomCommand(phpunitCommand):
    # TODO: this could be generalized further
    def execute_command(self, *args, **kwargs):
        self.load_settings()
        self.validate_command_runnable(*args, **kwargs)
        self.window.show_input_panel(
            'PHPUnit Arguments:',
            ' '.join(self.generate_base_phpunit_command()) + ' ',
            self.execute_custom_command,
            None,
            None
        )

    def execute_custom_command(self, command_str):
        command_segments = shlex.split(str(command_str))
        self.run_shell_command(command_segments)
