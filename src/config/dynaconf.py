from dynaconf import Dynaconf, LazySettings

settings: LazySettings = Dynaconf(settings_file=["settings.json"], environments=True)
