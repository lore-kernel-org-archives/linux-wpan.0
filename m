Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44190 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeIZU7e (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 26 Sep 2018 16:59:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id 36-v6so28416100oth.11
        for <linux-wpan@vger.kernel.org>; Wed, 26 Sep 2018 07:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535039998.git.starnight@g.ncu.edu.tw> <f7ea222671a2bc6fe0a060c4bdb1ebae162d0d91.1535039998.git.starnight@g.ncu.edu.tw>
 <f74c033a-fadc-fb8c-9469-6e6a32339cd8@suse.de>
In-Reply-To: <f74c033a-fadc-fb8c-9469-6e6a32339cd8@suse.de>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Wed, 26 Sep 2018 22:46:08 +0800
Message-ID: <CAC=mGzhOnEfx7NwURMbtc9eqOabu2_FYTz7aZKuEi6m72nUxXQ@mail.gmail.com>
Subject: Re: [RFC 2/3 net] lorawan: Add macro and definition for LoRaWAN class modlue
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?Q?Michael_R=C3=B6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?Q?Konstantin_B=C3=B6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "linux-kernel@vger.kernel.org>," <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Michal_Kube=C4=8Dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter ROBYNS <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>, fomi@rakwireless.com

Andreas F=C3=A4rber <afaerber@suse.de> =E6=96=BC 2018=E5=B9=B49=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8812:06=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Jian-Hong,
>
> Many thanks and sorry for the delay. This patch mostly looks good and
> should go in before its first uses, so I would like to queue it soon for
> my hardware-MAC module drivers - but some questions below. Also a typo
> in the subject, and we should probably prepend "net: " and I would
> personally not mention the module here as it's a userspace API.
>
> Am 23.08.18 um 19:15 schrieb Jian-Hong Pan:
> > This patch add the macro and definition for the implementation of
> > LoRaWAN protocol.
>
> I would fix up the grammar nits in my tree then.

Oh!  The grammar things should be fixed.  Thanks
And, I am preparing V2 patch, too.

> >
> > Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> > ---
> >  include/linux/socket.h              | 5 ++++-
> >  include/uapi/linux/if_arp.h         | 1 +
> >  include/uapi/linux/if_ether.h       | 1 +
> >  net/core/dev.c                      | 4 ++--
> >  security/selinux/hooks.c            | 4 +++-
> >  security/selinux/include/classmap.h | 4 +++-
> >  6 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index aa1e288b1659..e5c8381fd1aa 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -209,8 +209,9 @@ struct ucred {
> >                                */
> >  #define AF_XDP               44      /* XDP sockets                  *=
/
> >  #define AF_LORA              45      /* LoRa sockets                 *=
/
> > +#define AF_LORAWAN   46      /* LoRaWAN sockets                      *=
/
> >
> > -#define AF_MAX               46      /* For now.. */
> > +#define AF_MAX               47      /* For now.. */
> >
> >  /* Protocol families, same as address families. */
> >  #define PF_UNSPEC    AF_UNSPEC
> > @@ -261,6 +262,7 @@ struct ucred {
> >  #define PF_SMC               AF_SMC
> >  #define PF_XDP               AF_XDP
> >  #define PF_LORA              AF_LORA
> > +#define PF_LORAWAN   AF_LORAWAN
> >  #define PF_MAX               AF_MAX
> >
> >  /* Maximum queue length specifiable by listen.  */
> > @@ -343,6 +345,7 @@ struct ucred {
> >  #define SOL_KCM              281
> >  #define SOL_TLS              282
> >  #define SOL_XDP              283
> > +#define SOL_LORAWAN  284
> >
> >  /* IPX options */
> >  #define IPX_TYPE     1
> > diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
> > index 1ed7cb3f2129..2376f7839355 100644
> > --- a/include/uapi/linux/if_arp.h
> > +++ b/include/uapi/linux/if_arp.h
> > @@ -99,6 +99,7 @@
> >  #define ARPHRD_6LOWPAN       825             /* IPv6 over LoWPAN      =
       */
> >  #define ARPHRD_VSOCKMON      826             /* Vsock monitor header  =
       */
> >  #define ARPHRD_LORA  827             /* LoRa                         *=
/
> > +#define ARPHRD_LORAWAN       828             /* LoRaWAN               =
       */
> >
> >  #define ARPHRD_VOID    0xFFFF        /* Void type, nothing is known */
> >  #define ARPHRD_NONE    0xFFFE        /* zero header length */
> > diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ethe=
r.h
> > index 45644dcf5b39..b1ac70d4a377 100644
> > --- a/include/uapi/linux/if_ether.h
> > +++ b/include/uapi/linux/if_ether.h
> > @@ -148,6 +148,7 @@
> >                                        * aggregation protocol
> >                                        */
> >  #define ETH_P_LORA   0x00FA          /* LoRa                         *=
/
> > +#define ETH_P_LORAWAN        0x00FB          /* LoRaWAN               =
       */
> >
> >  /*
> >   *   This is an Ethernet frame header.
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f68122f0ab02..b95ce79ec5a8 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -297,7 +297,7 @@ static const unsigned short netdev_lock_type[] =3D =
{
> >        ARPHRD_IRDA, ARPHRD_FCPP, ARPHRD_FCAL, ARPHRD_FCPL,
> >        ARPHRD_FCFABRIC, ARPHRD_IEEE80211, ARPHRD_IEEE80211_PRISM,
> >        ARPHRD_IEEE80211_RADIOTAP, ARPHRD_PHONET, ARPHRD_PHONET_PIPE,
> > -      ARPHRD_IEEE802154, ARPHRD_VOID, ARPHRD_NONE};
> > +      ARPHRD_IEEE802154, ARPHRD_LORAWAN, ARPHRD_VOID, ARPHRD_NONE};
> >
> >  static const char *const netdev_lock_name[] =3D {
> >       "_xmit_NETROM", "_xmit_ETHER", "_xmit_EETHER", "_xmit_AX25",
> > @@ -314,7 +314,7 @@ static const char *const netdev_lock_name[] =3D {
> >       "_xmit_IRDA", "_xmit_FCPP", "_xmit_FCAL", "_xmit_FCPL",
> >       "_xmit_FCFABRIC", "_xmit_IEEE80211", "_xmit_IEEE80211_PRISM",
> >       "_xmit_IEEE80211_RADIOTAP", "_xmit_PHONET", "_xmit_PHONET_PIPE",
> > -     "_xmit_IEEE802154", "_xmit_VOID", "_xmit_NONE"};
> > +     "_xmit_IEEE802154", "_xmit_LORAWAN", "_xmit_VOID", "_xmit_NONE"};
> >
> >  static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lo=
ck_type)];
> >  static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lo=
ck_type)];
>
> All your new constants except SOL_LORAWAN are always next to a LoRa one,
> but not in these two arrays. I don't have such changes in my original
> LoRa patch - am I missing such an array extension for ARPHRD_LORA then,
> or what is the criteria for when to add this?

That is for "ip" related commands or something else I did not discover.
For example:
$ ip link show lora0
4: lora0: <NOARP,UP,LOWER_UP> mtu 20 qdisc noqueue state UNKNOWN mode
DEFAULT group default qlen 1000
    link/[828] 01:02:03:04 brd ff:ff:ff:ff

The 828 is ARPHRD_LORAWAN.

Regards,
Jian-Hong Pan
