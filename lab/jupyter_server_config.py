c = get_config()  # noqa
# Disables check from polluting project folders and ty/ruff
c.FileContentsManager.checkpoints_kwargs = {'root_dir': '/tmp'}
