flutter示例程序

## 在web时选择渲染引擎

详细参考以下链接：https://docs.flutter.dev/development/tools/web-renderers

```shell
flutter run -d chrome --web-renderer html
flutter build web --release --web-renderer auto --dart-define=FLUTTER_WEB_CANVASKIT_URL=canvaskit/  
flutter build web --release --web-renderer auto
```

在本地模拟生产环境资源托管
```shell
cd dist
http-server --cors
```


