Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996473;
	b=VJl8ju3t5pcWrhzAowuETS5hBA+JCk/9HkkLw+UAu9vqJCWiBROh1t22fYJXe2p36rAW
	 kG9m/+qpGVDGYmdd1CNjyHGYpidzDVSAlyvMwpFnhzVhPlaytOuj98AnKO3ckK5CXU/lL
	 ogq1NNi4Z7uGB0W4xU5BU4b0AfMkgl5GBvWqqmCAhsfd8r/JyFodf8WzCw0HnV1zjzqTq
	 3wcA3i9UzHnVjrINw4Cj+Xt7koaz6V9cOm5PBmcaGJ6JvdSRYvWC6l5/ln0ZUzFc1hMXr
	 3uqkp+uuAnGg8R3x3zs0reJbuS8GxiDE6mlFZAWX2tUcbDbejbL4Ia72w0pb5jm3jWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=959BkSk1iLBff7LPQ529CGwQXCG+nKTMirz/dSsXx4M=;
	b=s84tSaqLWR6FzhPOMiLmx8eIzbppNr2HUZkJc/paYOxx5Q4B1NuZQsygm/WmF/bkauYO
	 x3FvRpqq3TalmWE5bjbruSt19Gc8i5PrrUjekivH4eKl7PLmD2eEQFPKElLfg5qE3mCei
	 ISjUdVRnN9KB3jLionK8dKDSU/yZYo1a0SltSGgeWHg362gBN5a5IdL7k+y8NwVrMkc16
	 dNau/djNn5M3msoC95Ig5FGAHLeju5JgI6ujUGDv+6FwL6ZamjudhuQa/9t6KdnCrXaxh
	 V+KsP/AJ6kUpWjMA/Wl6yo9IstMtIMSqY6Nk1MgXdUMdJ4K7bRtdOxwcu2sYIQ8NP3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7A85JKW;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42645606A32F
	for <linux-wpan@vger.kernel.org>; Fri,  6 Nov 2026 20:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42645606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7A85JKW
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5e948e56af3so449011e0c.2
        for <linux-wpan@vger.kernel.org>; Fri, 06 Nov 2026 12:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996472; x=1794601272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=959BkSk1iLBff7LPQ529CGwQXCG+nKTMirz/dSsXx4M=;
        b=t7A85JKWAHrwaV2NDDfjT6j94ns+4EQEuPbv6LjFm7Pl1Lq4iltZ//g0XKX+q79+hx
         9q4moiD2bLg2DnqtWQUuNXYnHVUOfOemr6W4aUjyfb8NwusIHAslcfZa8bHiom3Ew25S
         hzUkpSMiwUeO2EPhCuazssJ9d4RghqllVytbdCYnn8l0YMOPONm+oLnrKHVRtzNSMdQC
         9dPBo48IrA2GGXXArP3NC8uXSev5XR5WKY4P8NpmCUPikQkoheTEuJWtPyORYzhbOn0g
         Ybxy9vdd3d64pI2qocDhbC3zSBnZaIYr5XM2S+Ee+11Eghs/Kvtrn2Vk/yWrT5LKYAb9
         PQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996472; x=1794601272;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=959BkSk1iLBff7LPQ529CGwQXCG+nKTMirz/dSsXx4M=;
        b=ogVJM2XdRVT8ZGpKxfKmIDPnKaFkriUkI+o0IqcHB7jJSIcyl8B4L1NyUGfzjcJZi4
         BuiJ3QNn6KhtAAS8PBIFioZ/6sN+XONBTF8Gb2ts4qx1d3N5RURWK+Qm2Cld0tmPvl2D
         F9kJVNRpPxl8Yu9cNcBEN53hseJyGy22vTy3+v6P5e6gEW3FVlGOeiDTsXBMdQexpWjl
         0t3XNZYPxH99Tnc8w0E+z55Ag/98kei3A0G1xeAOr/tugUG+qg+O5imZTFX7i/6EqLnq
         3j3pKup5blpPCslS8mXt+yNTdO2ghg5c8887HoYnZFdGRqX6k7nRaI0Wdp8hyNNKvdYf
         qavg==
X-Forwarded-Encrypted: i=1; AL+hErFaXC7V+ijtfCDB4vzcJJCCxk5qWvamBF5NrqSE8iN0D+sWJ3ArHjm2HzATawV/T/PRJyEHmoCT+cyN@vger.kernel.org
X-Gm-Message-State: APuU4Z92Z87pRUn7uK9uLiAguYTeGuzDrK3QUMK3b8vfwBdc28N2T7bE
	dXEoM2EM1YKrfKbfVGWDpn7Zsx28wWrUF4T7IbZ1w2K7BkYSp9e3EwnW
X-Gm-Gg: AYBFou22S2Xpw0frjjlEj7lG1lrjvJsHnPLkNVw85k3vT4lUKIDbvAtgHLDelK3oaBw
	QPwAJPyGqPtHmG2g+auJmsOLmIwBSuiz2XzKyjcafZV6gd4/Ps2HUX1AzDmR6TZ5Idq8VC3v8Pd
	1l+S/FZOPZFei1H6j8QiTwTCILOO60JmWKr9aEZy8Jua2DrtIfgObUyToH8xjUS2imyUoRgZXIq
	AWMX6EDS2e19+I4VN886kbMPOIVzybGyP1sSUkqhG8n9GBogPke+PuTxvdCsBkFgqqNH+dgqog1
	qe5Qqat0jRnLS+icFB9g0BqP13krMyzPlJfR2RdES1iRaX7imJ89sM7T4jO7yw2rn4uavL/+Gvr
	x6NZXkxzYME7wOzduCHF3XYi95QA1Swi7bxWz5bZuesk4Z9AZumC4owb0yUbH0EpBm5XchAQhcF
	vcSYFy8e0DgvVUJQQ6Z1ut664d6thI2rtD9LVqpNUGQqLhuCjX6tHQprTQmJDhKNAR9MgbogT9I
	8WlZ8UAf3JOjQM2TYFDIdh6PeDtpy+rySJexa2RhbyH0oF7uz8oqeumyiafsf9e0fWzOk8k9sI5
	49ScGwqvxCX1MG9+MKo/SozKhaV+SsUW+hCNWV3LONyF5Eq76MhRPtLzK5grmgX9DYwcYPc+vBm
	OpNTIpOKHns9AOayvdbH6iId5K5LxjiLE2gkm2sllJnhBNZUdqyh5QkQljD1Hw2iPLMBm1FY=
X-Received: by 2002:a05:6123:106:b0:5ea:b04a:cefd with SMTP id 71dfb90a1353d-5ecc43bb994mr1885195e0c.7.1793996472087;
        Fri, 06 Nov 2026 12:21:12 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc614d650sm2184819e0c.0.2026.11.06.12.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:21:11 -0800 (PST)
Date: Fri, 06 Nov 2026 15:21:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemb@google.com>, 
 Kalpesh Solanki <skalpesh942@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 alex.aring@gmail.com, 
 stefan@datenfreihafen.org, 
 miquel.raynal@bootlin.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.2cb4407542f65@gmail.com>
In-Reply-To: <CA+FuTSfzzoJN+wsVekOWcn18RKKYgp5AqCOpxh4taG=YAOQ9kg@mail.gmail.com>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
 <20261106142421.17793-1-skalpesh942@gmail.com>
 <CA+FuTSfzzoJN+wsVekOWcn18RKKYgp5AqCOpxh4taG=YAOQ9kg@mail.gmail.com>
Subject: Re: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via
 TUNSETLINK
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn wrote:
> On Fri, Nov 6, 2026 at 9:32=E2=80=AFAM Kalpesh Solanki <skalpesh942@gma=
il.com> wrote:
> >
> > A userspace application can set the link type of a TUN/TAP interface
> > to ARPHRD_IEEE802154 or ARPHRD_IEEE802154_MONITOR via ioctl(fd,
> > TUNSETLINK, arg) because tun_get_addr_len() explicitly recognized
> > these types.
> >
> > However, TUN devices cannot function as IEEE 802.15.4 radios (they
> > lack wpan_phy, channels, PAN IDs, and MLME operations), and tun
> > never initializes dev->ieee802154_ptr or dev->ml_priv.
> >
> > The IEEE 802.15.4 subsystem operates on the invariant that any
> > net_device with dev->type =3D=3D ARPHRD_IEEE802154 is a genuine WPAN =
device
> > with a valid dev->ieee802154_ptr context. When an unprivileged user
> > creates a TUN interface in a user+net namespace, changes its link typ=
e
> > to ARPHRD_IEEE802154, and issues a netlink dump request (such as
> > IEEE802154_LLSEC_LIST_KEY), ieee802154_llsec_dump_table()
> > unconditionally dereferences dev->ieee802154_ptr /
> > ieee802154_mlme_ops(dev), triggering a supervisor null-pointer

Apparently a similar issue affects ARPHRD_6LOWPAN.

> > dereference / general protection fault. Similar dereferences occur
> > across net/ieee802154/nl-phy.c (ieee802154_del_iface) and
> > net/ieee802154/socket.c.
> >
> > Rather than scattering NULL checks across every site in net/ieee80215=
4/,
> > fix the issue at the source: validate that arg fits within unsigned s=
hort
> > (rejecting arg > USHRT_MAX to prevent upper-bit truncation), disallow=

> > setting ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR via TUNSETLIN=
K
> > by returning -EINVAL, and remove these unsupported types from
> > tun_get_addr_len() along with the unused <linux/ieee802154.h> include=
.
> =

> I don't think we can do this.

One exception is if this has never worked. If this was a NULL ptr
exception from the start, then clearly no userspace can depend on it.
 =

> TUNSETLINK is a weird quirk. It never intended to fully change the link=

> layer. IFF_TAP still only supports Ethernet (calls eth_type_trans).
> =

> It was added in commit ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linkt=
ype
> of the tap device from userspace"), seemingly exactly to be able to pro=
cess
> other protocols.
> =

> Kismet would write captured 802.11 frames into a tap. The device would =
be
> labelled ARPHRD_IEEE80211* so that tcpdump or wireshark interface would=

> see the "right" link type for processing.
> =

> > Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETL=
INK processing")
> > Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D9ea34da5ca6100593c9=
0
> > Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
> > ---
> > v1 -> v2:
> > - Instead of adding NULL checks in net/ieee802154/nl-mac.c, disallow =
setting
> >   ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR link types via TUNS=
ETLINK in
> >   drivers/net/tun.c, as discussed with Andrew Lunn and identified in =
Sashiko
> >   bot review. Virtual IEEE 802.15.4 interfaces are properly provided =
by
> >   mac802154_hwsim and fakelb; TUN devices cannot function as genuine =
802.15.4
> >   radios and lack private 802.15.4 contexts.
> > - Add an explicit bounds check (arg > USHRT_MAX) to prevent integer t=
runcation
> >   bypasses when casting 64-bit ioctl arg to 16-bit dev->type.
> > - Remove ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR from tun_get=
_addr_len()
> >   and drop unused <linux/ieee802154.h> header.
> >
> >  drivers/net/tun.c | 45 ++++++++++++++++++++++++++-------------------=

> >  1 file changed, 26 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index dcec7311e60..f2915e929e3 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -70,7 +70,6 @@
> >  #include <linux/bpf.h>
> >  #include <linux/bpf_trace.h>
> >  #include <linux/mutex.h>
> > -#include <linux/ieee802154.h>
> >  #include <uapi/linux/if_ltalk.h>
> >  #include <uapi/linux/if_fddi.h>
> >  #include <uapi/linux/if_hippi.h>
> > @@ -3183,9 +3182,6 @@ static unsigned char tun_get_addr_len(unsigned =
short type)
> >                 return 4;
> >         case ARPHRD_ETHER:
> >                 return ETH_ALEN;
> > -       case ARPHRD_IEEE802154:
> > -       case ARPHRD_IEEE802154_MONITOR:
> > -               return IEEE802154_EXTENDED_ADDR_LEN;
> >         case ARPHRD_PHONET_PIPE:
> >         case ARPHRD_PPP:
> >         case ARPHRD_NONE:
> > @@ -3362,22 +3358,33 @@ static long __tun_chr_ioctl(struct file *file=
, unsigned int cmd,
> >                         netif_info(tun, drv, tun->dev,
> >                                    "Linktype set failed because inter=
face is up\n");
> >                         ret =3D -EBUSY;
> > -               } else {
> > -                       ret =3D call_netdevice_notifiers(NETDEV_PRE_T=
YPE_CHANGE,
> > -                                                      tun->dev);
> > -                       ret =3D notifier_to_errno(ret);
> > -                       if (ret) {
> > -                               netif_info(tun, drv, tun->dev,
> > -                                          "Refused to change device =
type\n");
> > -                               break;
> > -                       }
> > -                       tun->dev->type =3D (int) arg;
> > -                       tun->dev->addr_len =3D tun_get_addr_len(tun->=
dev->type);
> > -                       netif_info(tun, drv, tun->dev, "linktype set =
to %d\n",
> > -                                  tun->dev->type);
> > -                       call_netdevice_notifiers(NETDEV_POST_TYPE_CHA=
NGE,
> > -                                                tun->dev);
> > +                       break;
> > +               }
> > +
> > +               if (arg > USHRT_MAX) {
> > +                       ret =3D -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               if (arg =3D=3D ARPHRD_IEEE802154 || arg =3D=3D ARPHRD=
_IEEE802154_MONITOR) {
> > +                       ret =3D -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               ret =3D call_netdevice_notifiers(NETDEV_PRE_TYPE_CHAN=
GE,
> > +                                              tun->dev);
> > +               ret =3D notifier_to_errno(ret);
> > +               if (ret) {
> > +                       netif_info(tun, drv, tun->dev,
> > +                                  "Refused to change device type\n")=
;
> > +                       break;
> >                 }
> > +               tun->dev->type =3D (unsigned short)arg;
> > +               tun->dev->addr_len =3D tun_get_addr_len(tun->dev->typ=
e);
> > +               netif_info(tun, drv, tun->dev, "linktype set to %d\n"=
,
> > +                          tun->dev->type);
> > +               call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
> > +                                        tun->dev);

If blocking this proves safe, prefer as little unrelated code churn as
possible.

> >                 break;
> >
> >         case TUNSETDEBUG:
> > --
> > 2.53.0
> >
> >


