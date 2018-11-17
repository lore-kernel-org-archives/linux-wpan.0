Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi1-f178.google.com ([209.85.167.178]:46907 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeKQQsi (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 17 Nov 2018 11:48:38 -0500
Received: by mail-oi1-f178.google.com with SMTP id x202so10059385oif.13
        for <linux-wpan@vger.kernel.org>; Fri, 16 Nov 2018 22:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
 <20181114160126.4445-5-starnight@g.ncu.edu.tw> <20181116.203250.116640520195643915.davem@davemloft.net>
In-Reply-To: <20181116.203250.116640520195643915.davem@davemloft.net>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Sat, 17 Nov 2018 14:32:59 +0800
Message-ID: <CAC=mGzgeh=qh-FBBiwKH=4aNxVcrfqojtTWkdVLy3FkF9a9V3w@mail.gmail.com>
Subject: Re: [PATCH V3 4/7] net: maclorawan: Add maclorawan module declaration
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>

David Miller <davem@davemloft.net> =E6=96=BC 2018=E5=B9=B411=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8812:32=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> Date: Thu, 15 Nov 2018 00:01:25 +0800
>
> > + * @rx1_window:              RX1 window opening time in mini-seconds
> > + * @rx2_window:              RX2 window opening time in mini-seconds
>
> What is a "mini-second"?

Spelling mistake.  It should be millisecond.
Thanks for pointing out
