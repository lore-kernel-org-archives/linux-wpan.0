Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34094 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751223AbcLEERg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Dec 2016 23:17:36 -0500
Message-ID: <1480911392.2629.12.camel@decadent.org.uk>
Subject: Re: [PATCH] linux-firmware: update firmware file for atusb
From: Ben Hutchings <ben@decadent.org.uk>
Date: Mon, 05 Dec 2016 04:16:32 +0000
In-Reply-To: <1480857912-12695-1-git-send-email-stefan@datenfreihafen.org>
References: <1480857912-12695-1-git-send-email-stefan@datenfreihafen.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ni2oEmrC23UE1yQzV57+"
Mime-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>, linux-firmware@kernel.org
Cc: linux-wpan@vger.kernel.org


--=-ni2oEmrC23UE1yQzV57+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2016-12-04 at 14:25 +0100, Stefan Schmidt wrote:
> Update to newly released 0.3 version while also adding another
> file for the slightly different Atmel Raven USB dongle to be
> supported by the same kernel driver.
>=20
> > Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> ---
> =C2=A0WHENCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A04 +++-
> =C2=A0atusb/ChangeLog=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A09 +=
+++++---
> =C2=A0atusb/atusb-0.3.dfu | Bin 0 -> 6042 bytes
> =C2=A0atusb/rzusb-0.3.bin | Bin 0 -> 6058 bytes
> =C2=A04 files changed, 9 insertions(+), 4 deletions(-)
> =C2=A0create mode 100755 atusb/atusb-0.3.dfu
> =C2=A0create mode 100755 atusb/rzusb-0.3.bin

Permissions are wrong.

> diff --git a/WHENCE b/WHENCE
> index d021c40..e28cfd8 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -3129,7 +3129,9 @@ Licence: Redistributable. See LICENCE.nvidia for de=
tails
> =C2=A0Driver: atusb - ATUSB IEEE 802.15.4 transceiver driver
> =C2=A0
> =C2=A0File: atusb/atusb-0.2.dfu
> -Version: 0.2
> +File: atusb/atusb-0.3.dfu
> +File: atusb/rzusb-0.3.bin
> +Version: 0.3
[...]

Each Version field refers to the previous File field, so you should
leave 0.2 there for the old file and specify 0.3 for each of the new
files.

Ben.

--=20
Ben Hutchings
I'm always amazed by the number of people who take up solipsism because
they heard someone else explain it. - E*Borg on alt.fan.pratchett


--=-ni2oEmrC23UE1yQzV57+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlhE6iAACgkQ57/I7JWG
EQnLRw/+LTJJgTxSed8rvZjvrJSyJ6WGbuU2mbQg5xRyvwH05koPK5oe0EW72lm0
Uh2osggdeEB0XCICt2IvvkRZQ4lqnLNkYe2e+7zW6yLkxkvMFMIZkno+kYffdwPG
7z/z+xSzx+200G4+gelYPdUjSq/1AgL/IjDh02xhc86NF4Eb2h7nFjHO9UMK34Gc
RchZ9b/n+fPx7GdP9HRdFAy0GWfDMIcJRfGZCtiLMqmxdmIHpj9a912O4fOWDfCc
/YTHysuM9L5tMaA7eWrDgg/AOGkHmeVDOmdIBRfHVCeqnVZithmW+rIVh4qamsNH
Ktdx6TOWnqLu/LfIKqIYUYsZBS4ABCCOQXumf7yPQvRZDLx6E6bueel6CfYg/Yx7
eJ+/FC6nShjBj0AXRKJTk4AwnsqgSv2lydVpk257/+mrI9kPold2AhxkQhsAbpL0
ko94IS0D9FvC+P/NxkN4z12cpECmi1nvGuc5zpfBK7vw3mnBaBKuM5lVq6D9Fuln
4mIYZtHqOg6tdSHjBn+ozsixPcy2M2euwI5yzzZhT4zUrQE0zLM1pTD03Ok0fbNc
X6nfpeDyssSUkLl4GT4FBjyE+Gd3SCY90vtE9tl5/vWgjGgzhtlQeKIIukK2qY9v
lCSUTWHgC3VHSKFJciLpq71go0ffbAU4ZCr3OyYC0GDW6s0RQ2E=
=6ERV
-----END PGP SIGNATURE-----

--=-ni2oEmrC23UE1yQzV57+--
