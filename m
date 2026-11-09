Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241317;
	b=NT7Okpoera7w0dFVDaDtzvLcyYGX2p0+oSXlRsradzhG0ySEX3VIixMlviza5lB7Z+wi
	 n47sm6G/YHwF2WuN7BVLM9xq5ZscyGsAWXw8aYBkdLI4A4ltgQefW/6H/U2tVOnhPPNvx
	 dWbkjXfEHfrBQ7tveh1rdRZIT1G2pjzf9b3ZxMgCWT/FwV6Fpd3HqBf7yaISy3eBi8QXk
	 D/lnK1KVf0DzUb6EciWXId/fslALnH0sYRBNRW5gbPqjvxZ4v86+mefP87SZ1m8YZ7zw3
	 PGV4A+sSpUX1OjhnYdKoDEU/EN/spwbBYxzkybvEvUsp3x6BEq72LWa3gmzDnpdFW1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BYPTkk/4BunQr6t7vq/ZOQ1XWuSd/WG5xS8ifOxf1Lo=;
	b=WffglVdNcUqVqYuqKb5hUjFOuinvfIOorxpWLNrD/26qixjbculbx8BCBZKaZRiMSFRw
	 zSneBNsaN4VDy/1aNNBH6e2XGnrkjNb/wsWipDjlxg91G/gVA5+kjL3raz2mfRKRJebvz
	 3/uxMLlmfsf/RA5xQnZiAQPUnPrPa9PUk8ijohf1r5VGXNQDG2h81D/pgt7tj+oFgFp6f
	 nMLC2Qb5eO+aLdwfaOe/id+Zf88cBIYacKi0CMWKmOjjcGYsCRDl0GrPVzbZ6XEDYNb6J
	 jqpo+gV/1t0P09jj+r2q3Q5S1zcCbxQ7bfz6LyB/z9qE9ckbD3N9EYOEG80JFxSuUbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fJs9VWZ/";
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D048606A31C
	for <linux-wpan@vger.kernel.org>; Mon,  9 Nov 2026 16:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D048606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fJs9VWZ/
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ee029fd76aso467829e0c.1
        for <linux-wpan@vger.kernel.org>; Mon, 09 Nov 2026 08:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241316; x=1794846116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BYPTkk/4BunQr6t7vq/ZOQ1XWuSd/WG5xS8ifOxf1Lo=;
        b=fJs9VWZ/D6Zrq4tHCM/tTaabajQiokI5fKewOJzDRs5IS8KspKYj0dDdxANJBHdVMh
         tdaqSjQLDlakszKo3L0QuF9bEIoXXlM3v+PhugbNXBaYEI4WhZFI+TFRZUeDRimiSA3l
         fFMz/rzKb9ZY7w9xIIhsg0i/nuKM7mqi99g3h12a6cMWirwiauRWpPJzT12d/wbwtWX9
         EavcRosymWl7MLB8U0uP6/tZW3EFQru6Ksn9gKBXYyKqRF0rLAUiomE/jQuR2YvdbJvz
         pMpkI8SfZmNeD45z9ekErRNnLuJIiKV/Cp7IZD2h6ImavO05rvL5qjH7vY2lv6B4E8RV
         9qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241316; x=1794846116;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BYPTkk/4BunQr6t7vq/ZOQ1XWuSd/WG5xS8ifOxf1Lo=;
        b=v5FFCrHJwqIJjiYvwh0srKnH/AkMzHgowjEJ/Y2ud+0bxEZnc8HpoD6kn7uKPJQ4Lp
         L38BPBhFiQC/DXvFNOtRhIwwncefeKsh4EfHS6lCtmcqHG35mNPjTiTkoEYxsguOBdjw
         VC5FO3cRllVbFjduTHhl3PeLwDg+nsTieN4CtdyT+uCoLrL6MHEfu0yaeCsBkGUZ5MJS
         tDQIO5oeGTFEBXaAD8xfBZQr6LlJWe9GXFaWlMWs2aUd26d0vqXWukslFfmJaJBAnSMH
         YrqV3pA+L2SDvsAs99VSZ0K+8hIvZtw1jZoRS1/leQ0zz1c9AJye72B+72xYltBuGxi/
         drmg==
X-Forwarded-Encrypted: i=1; AL+hErGBAZW+rEMnOe5ciOAo/A7rxv6+Cl5DGfswaEZq83DUdxiqxbcx4135KEXkP9bbLbhuogvhQRDiMokI@vger.kernel.org
X-Gm-Message-State: APuU4Z9X9JXudQ+5VkY9iuWlHaEQmU3V4zVK+/ftApjxZMoN6Sk1gzpN
	qhd6JQyjLt5mrrLCSNJmBNlJ0r22JOKQ+77BuStllyOa3Z86aM2xeERNw+a5Bw==
X-Gm-Gg: AYBFou2hgxJIJX6qdflyFVugBUp3gThNKUaY9HsOM/gJ2CDm3Xv6US4SRhe0qb0n7FI
	vX123JCBd5xYn5gNVArNpWoncpyMLq8K6CenILRUj07b0IiLsoMfkIrNkDdQS6bRIjgy4na83Xg
	qXqIZiCJFR89q+BmmN8DsowMxXuZa2IEYjZFVTg7SMtGNDfFcsSaeIW3bRZE+lUYLTJoEhF3meq
	+Uou3rQCCztZcjiMt5Gcewst/X/a3XEa5NOjH9HdQImEtQcvPubGUt8vv5dpqiStMocDBGAKhaO
	7upeCCcw5ryglsivV9YYwDfFY+NfBl7APGmADsHMTqgwCZEfR5+aub0Nco5attcE39VeUxDYiai
	4nr4gmcjfw525vzTiRcnqOrTKpSbbMv4rJmlRaZF4sBaUMG9ZuK7IfVxQtTSc0ouO3/9YX0+BVK
	Hxn1hMWP/4nhW8qzfDe5bbZ2PIZlqLpZVSROVG+dIOGmGN7EImNlHHgKlzdJzUW222IgChG8zqC
	HLq0Nz/7wSGCyuqdqzP7Ti5Il44/jWk49viweMWixaH/u2IvTulqrAcgdayNUY3AOtM9SxXTR/9
	zCYTWhztPFW4rgQibTxqTALqYR/cXNHR4XDRzKZGQ+/+OmHeP8SqS2yRc6FL0wzNnHXTx47UW8S
	AsCEuQQwmxxah08O2TihvhTggvYHNNaKi1ESuPGMXkiDgA8dDhHhRK7QryMb0nO23vc6Vb5udhx
	5ShauALt3L27xF9zP90A==
X-Received: by 2002:a05:6122:4890:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5ece735964cmr1685538e0c.20.1794241315788;
        Mon, 09 Nov 2026 08:21:55 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe12dsm21301241.5.2026.11.09.08.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:21:54 -0800 (PST)
Date: Mon, 09 Nov 2026 11:21:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kalpesh Solanki <skalpesh942@gmail.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 alex.aring@gmail.com, 
 stefan@datenfreihafen.org, 
 miquel.raynal@bootlin.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: andrew+netdev@lunn.ch, 
 linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com, 
 Kalpesh Solanki <skalpesh942@gmail.com>
Message-ID: <willemdebruijn.kernel.4bc56403b78e@gmail.com>
In-Reply-To: <20261109083037.22337-1-skalpesh942@gmail.com>
References: <20261109083037.22337-1-skalpesh942@gmail.com>
Subject: Re: [PATCH net v4] tun: disallow setting IEEE 802.15.4 and 6LoWPAN
 link types via TUNSETLINK
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
Content-Transfer-Encoding: 7bit

Kalpesh Solanki wrote:
> A userspace application can set the link type of a TUN/TAP interface
> to ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, or ARPHRD_6LOWPAN
> via ioctl(fd, TUNSETLINK, arg) because tun_get_addr_len() explicitly
> recognized these types.
> 
> However, TUN devices cannot function as genuine IEEE 802.15.4 or 6LoWPAN
> interfaces:
> 
> 1. They lack wpan_phy, channels, PAN IDs, and MLME operations, and tun
>    never initializes dev->ieee802154_ptr or dev->ml_priv. When an
>    unprivileged user creates a TUN interface in a user+net namespace,
>    changes its link type to ARPHRD_IEEE802154, and issues a netlink dump
>    request (such as IEEE802154_LLSEC_LIST_KEY),
>    ieee802154_llsec_dump_table() unconditionally dereferences
>    dev->ieee802154_ptr / ieee802154_mlme_ops(dev), triggering a supervisor
>    null-pointer dereference / general protection fault. Similar
>    dereferences occur across net/ieee802154/nl-phy.c (ieee802154_del_iface)
>    and net/ieee802154/socket.c.
> 
> 2. Similarly, the 6LoWPAN subsystem assumes via lowpan_dev(dev) that
>    netdev_priv(dev) is struct lowpan_dev. On a TUN device, netdev_priv(dev)
>    is struct tun_struct. On netdev events (such as NETDEV_DOWN in
>    net/6lowpan/core.c:lowpan_device_event), it clears bits in
>    lowpan_dev(dev)->ctx.table flags, which corrupts private memory inside
>    tun_struct.
> 
> Rather than scattering checks across subsystems, fix the issue at the
> source: disallow setting ARPHRD_IEEE802154, ARPHRD_IEEE802154_MONITOR, and
> ARPHRD_6LOWPAN via TUNSETLINK by returning -EINVAL. Cast arg to unsigned
> short in the comparison to prevent upper-bit truncation bypasses (e.g.
> arg = ARPHRD_IEEE802154 | 0x10000).
> 
> Fixes: ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype of the tap device from userspace")
> Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This may affect more protocols, and sashiko may surface that.
That can always be a separate follow-up.

> ---
>  drivers/net/tun.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e60..b50a7245be9 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3362,6 +3362,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			netif_info(tun, drv, tun->dev,
>  				   "Linktype set failed because interface is up\n");
>  			ret = -EBUSY;
> +		} else if ((unsigned short)arg == ARPHRD_IEEE802154 ||
> +			   (unsigned short)arg == ARPHRD_IEEE802154_MONITOR ||
> +			   (unsigned short)arg == ARPHRD_6LOWPAN) {
> +			ret = -EINVAL;
>  		} else {
>  			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
>  						       tun->dev);
> -- 
> 2.53.0
> 


