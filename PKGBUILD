pkgname=potato
pkgver=6
pkgrel=1
pkgdesc="A pomodoro timer for the shell"
arch=('any')
url="https://github.com/RixxLx/potato"
license=('MIT')
depends=('alsa-utils')
source=('potato.sh'
        'notification.wav'
        'LICENSE')
md5sums=('72e15b3cc9be3d2fd709d456360248c4'
         '4d9c161c8ca4698be1404d8db25cf163'
         '1ddcbd2862764b43d75fb1e484bf8912')
package() {
	install -D $srcdir/potato.sh $pkgdir/usr/bin/$pkgname
	install -D -m644 $srcdir/LICENSE $pkgdir/usr/share/licenses/$pkgname/LICENSE
	install -D $srcdir/notification.wav $pkgdir/usr/lib/$pkgname/notification.wav
}
