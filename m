Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44774 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXTdv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Aug 2018 15:33:51 -0400
Received: by mail-oi0-f68.google.com with SMTP id l82-v6so10527594oih.11
        for <linux-wpan@vger.kernel.org>; Fri, 24 Aug 2018 08:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535039998.git.starnight@g.ncu.edu.tw> <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
 <30b75248-7589-fc98-819f-2b68844522f1@infradead.org>
In-Reply-To: <30b75248-7589-fc98-819f-2b68844522f1@infradead.org>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Fri, 24 Aug 2018 23:58:29 +0800
Message-ID: <CAC=mGzjMm6OdJJXB=G0NEBkGASWyJv1cgeS=_wiUhDn+WYaqGQ@mail.gmail.com>
Subject: Re: [RFC 1/3 net] lorawan: Add LoRaWAN class module
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: rdunlap@infradead.org
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "linux-kernel@vger.kernel.org>," <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter ROBYNS <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2018=E5=B9=B48=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 08/23/2018 10:15 AM, Jian-Hong Pan wrote:
> > diff --git a/net/maclorawan/Kconfig b/net/maclorawan/Kconfig
> > new file mode 100644
> > index 000000000000..741992b059c6
> > --- /dev/null
> > +++ b/net/maclorawan/Kconfig
> > @@ -0,0 +1,14 @@
> > +config LORAWAN
> > +     tristate "MAC layer of LoRaWAN Network support"
> > +     select CRYPTO
> > +     select CRYPTO_CMAC
> > +     select CRYPTO_CBC
> > +     select CRYPTO_AES
> > +     ---help---
> > +       LoRaWAN defines a low data rate, low power and long range wirel=
ess
> > +       wide area networks. It was designed to organise networks of sen=
sors,
> > +       switches and actuators, etc automation devices.  It could opera=
te as
> > +       multiple kilometers wide.
>
> There are several things that I would change.  How about this instead?
>
>
>           LoRaWAN defines low data rate, low power and long range wireles=
s
>           wide area networks. It was designed to organise networks of aut=
omation
>           devices, such as sensors, switches and actuators. It can operat=
e
>           multiple kilometers wide.

That becomes better!  Thank you

> > +
> > +       Say Y here to compile LoRaWAN support into the kernel or say M =
to
> > +       compile it as modules.
>
>
> --
> ~Randy
