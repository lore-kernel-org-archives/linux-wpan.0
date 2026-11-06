Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984075;
	b=A2ylruQ1OqgOb3nrhzyRucBMacvHxw6b+Vy1l1cYaWACaA0XCIwvv+W+cOh4p6MpVViB
	 EDoWL+QgIYFPfgOgQVTc+y4KlSQDk2WQZufTPHhEket/tkOaD3r7Br/HCJU95jxDgQ3Y7
	 KmDAgT6d14FcWpVF8v+25+MoMmkTyRE5HytvQ4dalVsu53kphgTkm+rs2pSpNHgXrt/8U
	 InMmKKLSgYmxnyV6jPbIogLZoGfC5SU9JyiLLMNgdlhQ5fXIpo7P08UXcksPn91za4tZw
	 lr5uQralYBryQ0PRG8sFX/ijfrxB17KSn5R6mI3KMx0Tup/EwyLEMw4TRPzP/G7Ey9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dkFzuHJuzHv5RFwHabaXe83i/n2wBUC3b7ZSZTt+kHU=;
	b=KP2nPG0cRBQts+J4/EJgP1NiiwpAoXoyrqZNBzspC0M8qTm24j0pVs3maP67vHNIz3uI
	 TF9uQTp1/8bI7hgbyYS1dkST5WqmHx4nbLF/sHnAEKFBuu/F5bzIPRCLl2OPxdK+dGLv0
	 cH1KPtiLtBABcXH/RO3c6+fVGRAhiDt03Ht8E74GDjb3RjhAZX0fe6aYD/+wxf4QBMj6b
	 c4EFHXl6hOEdbR7svn/GqE9v5Hw5zyEIOHrV7EbgcpGtwvklLm4q5SnnhOzuunfbBIQyO
	 u4bBij738ZzJX2fLA1R2HrFnFSaxRo0fsYEU0VKse/um3cB/2HvZOePdXgZZdEjr5mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZ+ztJPy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51209606A329
	for <linux-wpan@vger.kernel.org>; Fri,  6 Nov 2026 16:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51209606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZZ+ztJPy
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bfc2ae6e9dso691232e87.0
        for <linux-wpan@vger.kernel.org>; Fri, 06 Nov 2026 08:54:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793984072; cv=none;
        d=google.com; s=arc-20260327;
        b=jwjOs9e6IZ9ped68lamLqs5V0k6RjT11b+OzDoRZJSzKnuHmjZHqvfQIdt+rCSbMrJ
         Icp6l+lpuMVcw0qGsAwetXO6HOE8C5kSMmEX68YXsR68SAFkjYUOWaRhounZRRQginl6
         GDPstiydJ3K5p6fMv1i+uIkff3ry/DZcC7aQ2gx1ClFB1TPo5OI4NReLlqzDtnFviehK
         QnmI/yETDcZX0OYANJIejePqphUzUufGg405T9CZC6hgsttbNpMp342WhR8tQAJ//0SO
         92vna9pf0kwBAu5kUYMl/j6Q6YTBs69rDqmBpsQOgmp0fjc75oN67ndP3bIXVQu1TrfQ
         e63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dkFzuHJuzHv5RFwHabaXe83i/n2wBUC3b7ZSZTt+kHU=;
        fh=EkvkGm15vfc1KjKst5DwxJto437CBojUX3rXo82Len4=;
        b=q2ncLDKItvkl5PwCRc3n+MINm2njRdM9X8c28RDLPyg5d5N2tFa8l+NsYaDqOxO1SQ
         W6endYUnoFYSIk9LJcOqVoFg/r1mYkgJNeQvPcPU4qDmQcVQ3cPJcq5rNttdPRLMOwtQ
         fibwmmnrXWxRnUm3VJIjjiOX5lEh48NVXUu6tYi3uBtNOjlgNF148nfc7U24G4+CndPm
         5rbev0QDl4RMdWtqskK7PJUOCfClQxA/dS5sUbjERVszylJPPdBMrBcL9wQIl4o4M3Ef
         pOHLT3B7YQnHYNFhceiMaJy5pyW3Fh/Wum1HMd9RJwHJq22htMXVNRqFP827O8xRkvet
         14fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793984072; x=1794588872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dkFzuHJuzHv5RFwHabaXe83i/n2wBUC3b7ZSZTt+kHU=;
        b=ZZ+ztJPybuGEZDjDgu29EnZYCNLMrx4Qz1zhAInaF2quJFv+yTeOBJR5AcJy4dV6FG
         DArFOitNv+XL0urRRS7nw8DyBASOAfCylSm5S3BraKZ6ZlyNoITijzVDXZAJf1qr8RuG
         A2umrMt2opRiqasRjGPe3srtriCn1cAdYRz+qMHy0XttlZqHLvVqbs2CWwgAFxkXHWtJ
         Mx9x9X9vkX339h/aZilD3laE+ec6c7hw29LPbLcQUVpz24Xcx5ncgtNZMrLAkFuATTHS
         xLCJUuBcIE55Z4gSObocZC+ZeUnyXeXY6Dj2D3CHoXu0cOMKM3TdbMOEkf0RQMOWm+cj
         gYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793984072; x=1794588872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkFzuHJuzHv5RFwHabaXe83i/n2wBUC3b7ZSZTt+kHU=;
        b=YzS4EZUp3mJtAjbgBNyvT7ANZ/So1MNjMJYrqG0LewGDebVUEQbr8BXrFWbdQdKzj9
         5SlgkDU3TtxFsfwwCsEPzBm9RI4agB3UJ4WVhTbV1NN/HRwGMoXtj7xcQh1m+Q4o5zYV
         Gp2bDtvMSjl7FnQxQf6PveG3h5jAEPiberTT+5HMXoXU8UKiH9VJT+Iqs9LiCQe02/4j
         86RjO+qca2Rn3ZNzuQoGcaPRB7W5pIWdimPKmEQ1NjYegtKzTggoMdShfjxBJiX8AH9z
         aXW/3fuzBPc8IiMuauVEh5RKexxBKQxTr1yZcqVKk7lSE7Vpo7M6oNOpDUgz2Rqwp2eu
         a8Bw==
X-Forwarded-Encrypted: i=1; AL+hErHj9uD90S98Jci2ggC3j3euwRwW7oLzLfg/sm0ZT6Px3k+aTnaFqNPoo+CIAahLWlha4C4PaSfspr7E@vger.kernel.org
X-Gm-Message-State: APuU4Z98Ng0cF1G7/zuzXUGfBAbUoVI7qOv3dlAbZja2qPkJ5FmqoOla
	tg3NGGf9GVuz+fkB0vtqb7Ip8o0H1ZOzE8l3CEBe0yhvUXqB9K14HK0CMRiJd1u11MZHGhAclz/
	Iy7DNLaWljQ43/R4NjxHTFhpro05PjRwigsGQTBU6
X-Gm-Gg: AYBFou2Yj41hyWWggK/5Yg9jRv5jDe+BxQbzcz+UfDpu1QZVxAAIgtKphFU+6dfrqLr
	1QHb6+VmOnNl0BZocnWZzxYXKq7qoBWPN0vlPVDiKoHRq80qwKISQIESz7qBomO0caoNiI3ozxm
	qD6NmGrZPl+NgZ76ME5HRHaWotRcgmf1SX2/yUjEOh0vv3MIWZsQ8cSScm/6iYfb7TiAtjhtsSo
	fyLMl2Q4BY+kuWzs4VIjBYjBAD6fZ3STjAGbQ4VJXN0PXuxT2jyjTtdm+1AFEVg//22avHjk4nG
	0N1gmAWYxSfFDdAOk6FWgNEcnVej43xQODQ1ykijcPVBMKoKKrptgq0tDZrEHa9H/lAGU5TkadR
	3WSR10xwOQYP7KBXOX2gFscqlq86DevaG5rV22eFCT0pyzWBYiyjhNKy/pIuHIlxqnXaJHiSour
	7NDMsaJALo2MrYdb8RNAQ+nXolaheM4tmtIA7Ht6mOmuW/vNs+nR35n59G3L42QC+lZVYsAEvr0
	52naopIb6GJiTWZ
X-Received: by 2002:a05:6512:b1e:b0:5be:3720:1393 with SMTP id
 2adb3069b0e04-5c003adf778mr1037616e87.51.1793984072100; Fri, 06 Nov 2026
 08:54:32 -0800 (PST)
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101092219.1278751-1-skalpesh942@gmail.com> <20261106142421.17793-1-skalpesh942@gmail.com>
In-Reply-To: <20261106142421.17793-1-skalpesh942@gmail.com>
From: Willem de Bruijn <willemb@google.com>
Date: Fri, 6 Nov 2026 11:53:53 -0500
X-Gm-Features: AclHuK_c_DfsmI33CCc1Uir_OkECB369Wp3N4hEOCBGMuQ9y0dY5VqQSiKnHFFY
Message-ID: <CA+FuTSfzzoJN+wsVekOWcn18RKKYgp5AqCOpxh4taG=YAOQ9kg@mail.gmail.com>
Subject: Re: [PATCH net v2] tun: disallow setting IEEE 802.15.4 link types via TUNSETLINK
To: Kalpesh Solanki <skalpesh942@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, 
	alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 9:32=E2=80=AFAM Kalpesh Solanki <skalpesh942@gmail.c=
om> wrote:
>
> A userspace application can set the link type of a TUN/TAP interface
> to ARPHRD_IEEE802154 or ARPHRD_IEEE802154_MONITOR via ioctl(fd,
> TUNSETLINK, arg) because tun_get_addr_len() explicitly recognized
> these types.
>
> However, TUN devices cannot function as IEEE 802.15.4 radios (they
> lack wpan_phy, channels, PAN IDs, and MLME operations), and tun
> never initializes dev->ieee802154_ptr or dev->ml_priv.
>
> The IEEE 802.15.4 subsystem operates on the invariant that any
> net_device with dev->type =3D=3D ARPHRD_IEEE802154 is a genuine WPAN devi=
ce
> with a valid dev->ieee802154_ptr context. When an unprivileged user
> creates a TUN interface in a user+net namespace, changes its link type
> to ARPHRD_IEEE802154, and issues a netlink dump request (such as
> IEEE802154_LLSEC_LIST_KEY), ieee802154_llsec_dump_table()
> unconditionally dereferences dev->ieee802154_ptr /
> ieee802154_mlme_ops(dev), triggering a supervisor null-pointer
> dereference / general protection fault. Similar dereferences occur
> across net/ieee802154/nl-phy.c (ieee802154_del_iface) and
> net/ieee802154/socket.c.
>
> Rather than scattering NULL checks across every site in net/ieee802154/,
> fix the issue at the source: validate that arg fits within unsigned short
> (rejecting arg > USHRT_MAX to prevent upper-bit truncation), disallow
> setting ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR via TUNSETLINK
> by returning -EINVAL, and remove these unsupported types from
> tun_get_addr_len() along with the unused <linux/ieee802154.h> include.

I don't think we can do this.

TUNSETLINK is a weird quirk. It never intended to fully change the link
layer. IFF_TAP still only supports Ethernet (calls eth_type_trans).

It was added in commit ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype
of the tap device from userspace"), seemingly exactly to be able to process
other protocols.

Kismet would write captured 802.11 frames into a tap. The device would be
labelled ARPHRD_IEEE80211* so that tcpdump or wireshark interface would
see the "right" link type for processing.

> Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK =
processing")
> Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D9ea34da5ca6100593c90
> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
> ---
> v1 -> v2:
> - Instead of adding NULL checks in net/ieee802154/nl-mac.c, disallow sett=
ing
>   ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR link types via TUNSETLI=
NK in
>   drivers/net/tun.c, as discussed with Andrew Lunn and identified in Sash=
iko
>   bot review. Virtual IEEE 802.15.4 interfaces are properly provided by
>   mac802154_hwsim and fakelb; TUN devices cannot function as genuine 802.=
15.4
>   radios and lack private 802.15.4 contexts.
> - Add an explicit bounds check (arg > USHRT_MAX) to prevent integer trunc=
ation
>   bypasses when casting 64-bit ioctl arg to 16-bit dev->type.
> - Remove ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR from tun_get_add=
r_len()
>   and drop unused <linux/ieee802154.h> header.
>
>  drivers/net/tun.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e60..f2915e929e3 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -70,7 +70,6 @@
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
>  #include <linux/mutex.h>
> -#include <linux/ieee802154.h>
>  #include <uapi/linux/if_ltalk.h>
>  #include <uapi/linux/if_fddi.h>
>  #include <uapi/linux/if_hippi.h>
> @@ -3183,9 +3182,6 @@ static unsigned char tun_get_addr_len(unsigned shor=
t type)
>                 return 4;
>         case ARPHRD_ETHER:
>                 return ETH_ALEN;
> -       case ARPHRD_IEEE802154:
> -       case ARPHRD_IEEE802154_MONITOR:
> -               return IEEE802154_EXTENDED_ADDR_LEN;
>         case ARPHRD_PHONET_PIPE:
>         case ARPHRD_PPP:
>         case ARPHRD_NONE:
> @@ -3362,22 +3358,33 @@ static long __tun_chr_ioctl(struct file *file, un=
signed int cmd,
>                         netif_info(tun, drv, tun->dev,
>                                    "Linktype set failed because interface=
 is up\n");
>                         ret =3D -EBUSY;
> -               } else {
> -                       ret =3D call_netdevice_notifiers(NETDEV_PRE_TYPE_=
CHANGE,
> -                                                      tun->dev);
> -                       ret =3D notifier_to_errno(ret);
> -                       if (ret) {
> -                               netif_info(tun, drv, tun->dev,
> -                                          "Refused to change device type=
\n");
> -                               break;
> -                       }
> -                       tun->dev->type =3D (int) arg;
> -                       tun->dev->addr_len =3D tun_get_addr_len(tun->dev-=
>type);
> -                       netif_info(tun, drv, tun->dev, "linktype set to %=
d\n",
> -                                  tun->dev->type);
> -                       call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
> -                                                tun->dev);
> +                       break;
> +               }
> +
> +               if (arg > USHRT_MAX) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               if (arg =3D=3D ARPHRD_IEEE802154 || arg =3D=3D ARPHRD_IEE=
E802154_MONITOR) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
> +               ret =3D call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
> +                                              tun->dev);
> +               ret =3D notifier_to_errno(ret);
> +               if (ret) {
> +                       netif_info(tun, drv, tun->dev,
> +                                  "Refused to change device type\n");
> +                       break;
>                 }
> +               tun->dev->type =3D (unsigned short)arg;
> +               tun->dev->addr_len =3D tun_get_addr_len(tun->dev->type);
> +               netif_info(tun, drv, tun->dev, "linktype set to %d\n",
> +                          tun->dev->type);
> +               call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE,
> +                                        tun->dev);
>                 break;
>
>         case TUNSETDEBUG:
> --
> 2.53.0
>
>
