import 'dart:developer' as developer;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:screen_s1ze/theme/theme_cubit.dart';
import 'package:screen_s1ze/widget/data_line.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:collection/collection.dart';
import 'package:screen_s1ze/widget/data_lines.dart';
class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  double _refreshRate = 0;
  double _brightness = 0;
  String _deviceModel = 'N/A';
  String _deviceId = 'N/A'; // Changed from _imei to _deviceId

  @override
  void initState() {
    super.initState();
    _getRefreshRate();
    _getBrightness();
    _getDeviceInfo();
  }

  Future<void> _getRefreshRate() async {
    try {
      final displayMode = await FlutterDisplayMode.active;
      if (mounted) {
        setState(() {
          _refreshRate = displayMode.refreshRate;
        });
      }
    } catch (e, s) {
      developer.log('Failed to get refresh rate', error: e, stackTrace: s);
    }
  }

  Future<void> _getBrightness() async {
    try {
      final brightness = await ScreenBrightness().system;
      if (mounted) {
        setState(() {
          _brightness = brightness;
        });
      }
    } catch (e, s) {
      developer.log('Failed to get brightness', error: e, stackTrace: s);
    }
  }

  // Updated to use device_info_plus
  Future<void> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String model = 'N/A';
    String id = 'N/A';
    try {
      // Platform-specific implementations
      if (Theme.of(context).platform == TargetPlatform.android) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        model = androidInfo.model;
        id = androidInfo.id; // Using androidId which is a unique ID for the device
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        model = iosInfo.model;
        id = iosInfo.identifierForVendor ?? 'N/A'; // A unique ID for the app on the device
      }
    } on PlatformException catch (e, s) {
      model = 'Failed to get Model.';
      id = 'Failed to get Device ID.';
      developer.log('Failed to get device info', error: e, stackTrace: s);
    }

    if (mounted) {
      setState(() {
        _deviceModel = model;
        _deviceId = id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final devicePixelRatio = mediaQuery.devicePixelRatio;
    final resolution = Size(
      size.width * devicePixelRatio,
      size.height * devicePixelRatio,
    );
    final safeArea = mediaQuery.padding;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Screen Overview'),
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: 
        //_infoGroupInCardStyle(size, resolution, devicePixelRatio, safeArea, _refreshRate, _brightness, _deviceModel, _deviceId),
        _buildInfoTree(context, {
          "Screen Size": {
            "Resolution (Pixels)": IntSizeValue.fromSize(resolution),
            "Size (Logical Pixels)": SizeValue.fromSize(size, fixedRound: 2),
            "Aspect Ratio": NumberValue(size.height / size.width, fixedRound: 2),
          }
        })
    );
  }
  Widget _infoGroupInCardStyle(Size size, Size resolution, double devicePixelRatio, EdgeInsets safeArea, double _refreshRate, double _brightness, String _deviceModel, String _deviceId) => ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
    
          const SizedBox(height: 16),
          _buildInfoCard(
            context,
            'Resolution (Pixels)',
            '${resolution.width.toInt()} x ${resolution.height.toInt()}',
          ),
          _buildInfoCard(
            context,
            'Size (Logical Pixels)',
            '${size.width.toInt()} x ${size.height.toInt()}',
          ),
          _buildInfoCard(
            context,
            'Aspect Ratio',
            (size.height / size.width).toStringAsFixed(2),
          ),
          _buildInfoCard(
            context,
            'Device Pixel Ratio',
            devicePixelRatio.toStringAsFixed(2),
          ),
          _buildInfoCard(
            context,
            'Density (Standard)',
            _getDensityString(devicePixelRatio),
          ),
          _buildInfoCard(context, 'Safe Area (Top)', '${safeArea.top.toInt()}'),
          _buildInfoCard(context, 'Safe Area (Bottom)', '${safeArea.bottom.toInt()}'),
          _buildInfoCard(context, 'Refresh Rate', '${_refreshRate.toStringAsFixed(0)} Hz'),
          _buildInfoCard(context, 'Brightness', '${(_brightness * 100).toStringAsFixed(0)}%'),
          const SizedBox(height: 24),
          Text(
            'Device Information',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildInfoCard(context, 'Device Model', _deviceModel),
          // Changed label from 'IMEI' to 'Device ID'
          _buildInfoCard(context, 'Device ID', _deviceId),
          const SizedBox(height: 24),
          Text(
            'Note: The following details require other packages or platform-specific implementations and are not available from MediaQuery:',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
          _buildInfoCard(context, 'Screen Diagonal (Inches)', 'N/A'),
          _buildInfoCard(context, 'DPI / PPI', 'N/A'),
          _buildInfoCard(context, 'Screen Corner Radius', 'N/A'),
  ]);

  Widget _buildInfoTree(BuildContext context, Map<String, Map<String, DataValue>> data) {
    return SingleChildScrollView(
      padding: const .all(20),
      child: Column(
      crossAxisAlignment: .start,
      children:  
      data.entries.map<List<Widget>>((group) => 
        [
          Text(
            group.key,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          DataLines(data: group.value)
        ]
      ).flattenedToList));
  }
  String _getDensityString(double density) {
    if (density >= 4.0) {
      return 'xxxhdpi';
    } else if (density >= 3.0) {
      return 'xxhdpi';
    } else if (density >= 2.0) {
      return 'xhdpi';
    } else if (density >= 1.5) {
      return 'hdpi';
    } else if (density >= 1.0) {
      return 'mdpi';
    } else {
      return 'ldpi';
    }
  }

  Widget _buildInfoCard(BuildContext context, String label, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}