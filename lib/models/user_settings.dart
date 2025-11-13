import 'package:hive/hive.dart';

part 'user_settings.g.dart';

@HiveType(typeId: 1)
class UserSettings extends HiveObject {
  @HiveField(0)
  late bool darkMode;

  @HiveField(1)
  late bool cloudSyncEnabled;

  @HiveField(2)
  late String unitSystem; // 'metric' or 'imperial'

  @HiveField(3)
  DateTime? lastBackup;

  @HiveField(4)
  String? userEmail;

  @HiveField(5)
  late bool voiceEnabled;

  @HiveField(6)
  late String defaultView; // 'grid' or 'list'

  UserSettings({
    this.darkMode = false,
    this.cloudSyncEnabled = false,
    this.unitSystem = 'metric',
    this.lastBackup,
    this.userEmail,
    this.voiceEnabled = true,
    this.defaultView = 'grid',
  });

  Map<String, dynamic> toJson() => {
        'darkMode': darkMode,
        'cloudSyncEnabled': cloudSyncEnabled,
        'unitSystem': unitSystem,
        'lastBackup': lastBackup?.toIso8601String(),
        'userEmail': userEmail,
        'voiceEnabled': voiceEnabled,
        'defaultView': defaultView,
      };

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        darkMode: json['darkMode'] as bool? ?? false,
        cloudSyncEnabled: json['cloudSyncEnabled'] as bool? ?? false,
        unitSystem: json['unitSystem'] as String? ?? 'metric',
        lastBackup: json['lastBackup'] != null
            ? DateTime.parse(json['lastBackup'] as String)
            : null,
        userEmail: json['userEmail'] as String?,
        voiceEnabled: json['voiceEnabled'] as bool? ?? true,
        defaultView: json['defaultView'] as String? ?? 'grid',
      );
}
