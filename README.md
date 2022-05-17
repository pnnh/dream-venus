flutter示例程序

## 在web时选择渲染引擎

详细参考以下链接：https://docs.flutter.dev/development/tools/web-renderers

```shell
flutter run -d chrome --web-renderer html
flutter build web --release --web-renderer auto --dart-define=FLUTTER_WEB_CANVASKIT_URL=canvaskit/  
flutter build web --release --web-renderer html
```

在本地模拟生产环境资源托管

```shell
cd dist
http-server --cors
```

## 手动进行brotli压缩

```shell
npm i -g brotli-cli   # 安装压缩工具
brotli-cli compress canvaskit.wasm
```
