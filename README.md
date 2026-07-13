# Só de Mercado

App Flutter/Dart de ecommerce para mercado, com vitrine de produtos, busca, categorias, ofertas, controle de quantidade e carrinho.

## Como executar

O Flutter SDK foi instalado em `C:\Users\maric\development\flutter`.

Nesta máquina, rode:

```powershell
& "$env:USERPROFILE\development\flutter\bin\flutter.bat" pub get
& "$env:USERPROFILE\development\flutter\bin\flutter.bat" run
```

Se o Flutter estiver no PATH, também funciona:

```powershell
flutter pub get
flutter run
```

## Plataformas

O projeto já inclui runners para Android, iOS, Web, Windows, macOS e Linux.

## PWA

A versão Web já está preparada como PWA, com `manifest.json`, ícones instaláveis,
meta tags mobile e service worker próprio para cache/offline.

Para gerar:

```powershell
& "$env:USERPROFILE\development\flutter\bin\flutter.bat" build web
```

Para testar localmente:

```powershell
npx serve build\web -l tcp://127.0.0.1:8080
```
