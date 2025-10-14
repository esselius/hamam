{
  perSystem =
    { config, ... }:
    {
      taskfile = {
        config.tasks.default = {
          cmd = "echo 'use -l to list tasks'";
          desc = "Default task";
        };
        runner.name = "hamam";
      };
      packages.hamam-cli = config.taskfile.runner.exec;
    };
}
