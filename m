Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34548 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeKQRCz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 17 Nov 2018 12:02:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so3158552oig.1
        for <linux-wpan@vger.kernel.org>; Fri, 16 Nov 2018 22:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-2-starnight@g.ncu.edu.tw> <aaee242e-a287-9db6-4374-73f2ee9fc9d2@suse.de>
In-Reply-To: <aaee242e-a287-9db6-4374-73f2ee9fc9d2@suse.de>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Sat, 17 Nov 2018 14:47:15 +0800
Message-ID: <CAC=mGzh=caPcg-98vCUx+tEsb482cWtw3TonXS=ARhssj3Tcaw@mail.gmail.com>
Subject: Re: [PATCH V3 1/7] net: lorawan: Add macro and definition for LoRaWAN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>

Andreas F=C3=A4rber <afaerber@suse.de> =E6=96=BC 2018=E5=B9=B411=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:12=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Am 14.11.18 um 17:01 schrieb Jian-Hong Pan:
> > This patch adds the macro and definition for the implementation of
> > LoRaWAN protocol.
> >
> > Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> > ---
> > V2:
> > - Modify the commit message
>
> Note that both v2 and v3 don't seem to be based on the latest lora-next
> branch, as your constants are already queued and used there.

Oh!  I see the commits now.  V4 patch set will follow the latest branch.

Thanks,
Jian-Hong Pan
