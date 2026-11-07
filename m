Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071593;
	b=vdOuHFKGKpte5xVt4o/N+R5+vGlSUC5K1rUBRh17O/mFE62dcF7enyI2VoNGSkXIhxCT
	 vVMnp0S5zGILJGrtecerP4oQMlJ40o5xnTpuK5bC3jZza3z63BQpd3Ef/rzpPBjoDQ9n3
	 i5pMQpGRAK6nqKgfLR4peV+jepkp2mVUUCnV0YmSYAnV+x6iQ7jcf2qLLZZcrnUGA6BoY
	 /onbI3qeo0B/IF+EvID07SiTX74S5ze1yRXtC8j5KoeZqzgMNnoOSLXGqz4mDoOFJWBti
	 KvlQjhRcV4zQIKf7o5kJhW/eS8uCzTi4O8r+tsnnzJ6y8PAFpLD6+CYNazYu9zO1fsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RrcIjc82wzLHRIBiu7WsbnPLnaaISGaTukITjRMdwK4=;
	b=y8r3x3v1BPvqZKpdaVYwNerk1vHrR99Gohhh+kAPLlAw7IC9cKxnwzjwtNPAdAJxr150
	 zH6zcganmqMCx9dj1ngpC271h+RlGPH5kpOIyRZyfOJaUFetVdbKOSGAOEBA2StZF7c34
	 IqpeuulQ+owMlzRFGX2Gkhxlvq3Awv3ZvIThuSIp5HdO2+6RqJQuQSYqHW8YHioCHluxu
	 C6cD/T5POznxLJLDNhsGUQDCrwII6IiVLFv2cYr8m5MhwNTFDj9uq2+xlvUKXrAutEwD6
	 xTT4uHxiNgkdt/dmQ7d7ggYk4XDR9UItFx4PL0/2G25y30FiAnDrHEJ2KUviGI3AAvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSKRq+Su;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F3606EE9F
	for <linux-wpan@vger.kernel.org>; Sat,  7 Nov 2026 17:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 623F3606EE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSKRq+Su
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ec6f271883so1137190e0c.3
        for <linux-wpan@vger.kernel.org>; Sat, 07 Nov 2026 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071592; x=1794676392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RrcIjc82wzLHRIBiu7WsbnPLnaaISGaTukITjRMdwK4=;
        b=LSKRq+Sub16VAsEMonpzRlOiZ8U/Plpyjo0xR2iYyxNNpt3DqQhh77kmf5d1aaRvti
         IyZhXH9yctfuza57fW/gCZP74SmXlTA4YxybQsjf6uITlQpHi39WwbzFBfjmHJuVO+Gk
         iQdTg3oJ9cpYc1ZmoFUBFuz79/TEvjwIL8YDIHzozD4wLMoy4Y2kWPfoC9VILYoSVr/E
         HRWn5S+FkoluHtTxKQiD/DB5X7aHTVcmofLixtW6CNTen71h88Vubkd+QhyfUReog68T
         rEwCnatBtUQqKCoKFSm8v16DmtVOf2V3BoRTUyIjCLyut6lNnDair7haTTLmVaNRvSSn
         TN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071592; x=1794676392;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RrcIjc82wzLHRIBiu7WsbnPLnaaISGaTukITjRMdwK4=;
        b=zFNKaYAOka7kmbtCzIS6kTJNbrw2gKPZatNM05QQoC4r62pb7/TVcIx2U/di+YgVDg
         j+KReOULPnffpZcGrlW38L9TpOfl7ABGQXWmCBTAYwR155T/CQotqMoJvtupBMaD5uLi
         qFnibg7cvNLM0GZ9xUKouAbUidnBYMY6eqBwlo7QnffV2hgUsahmdpdgEFb5+hXk1Led
         82UD7ZJLoSAaktLmKFQzsP4BndLB3oHa+P3C0vMxiu2L4+Ws0H0mcT42pDr0ixUZXzQD
         Mg565RSunu8FxVRfQjEsAUN2zrcya2muizjIOqLRuxyaVeab0OW3s1E1IOlxBzTRLVSn
         bOyg==
X-Forwarded-Encrypted: i=1; AL+hErFYA6hO9aHBPNqDaKXK82leeXoPMXAfzGHVych9ALa6j2jmg7d7avjpj9wz2Eqoy8jSplt6DkTiY8MA@vger.kernel.org
X-Gm-Message-State: APuU4Z8+D01AZiLJWEtI0+Vjzi0fowYvFT0SgwmMiZpjJVcM4M1WZwtY
	qRIUjSoN+Nuk1ERAJ1g4PriPyvZwadyWBliyxmd7gRKpzcZsZlo0NhhK
X-Gm-Gg: AYBFou1KtSJNTaMR+En2uzxQA5nhltGnC1ODODASNHLvJriRZEthQlUX12KfJWHmTkM
	PGF6BH6cYi7u0WzD9MvgkpgpvaqRj1Oq7ILUpgTj1XX3j45NXEo+0h4w7EUgeRxNGPGiDtx1aIJ
	EZDe15zv/iovSmW/1TXyOMurB7XgOd6jocP//EeVP+9NsCSxn9rXajCvK+3ElxCDIEU0Dm7pe8G
	Q5tRxaYgqMcmnhfHeVzcCihOaMDL/kFDXbTOUOc3qoCRO/FPtASc6zdLPL+Nb8yAZqkKfgsaNZb
	L+8fOjzuUN25H1erUz2dpMOKWueBPjfGn3ob6kMSBHa6wIQrJdX1R22b0Lt+k5kiCVTra0Ik44g
	EsprUtRtjtlobnUwQ+MHMDgbKALQ/VrAM5zRh/+hrGpfRNQWggv4eMycYofXO2Z45t5N24yf5OQ
	71W/Jf2FUg/Y+zKaj35Rv/Vma1DztSltB6oX9P+47pjZtyYVCJRFjvk9QcE86ONQWCmNULDm6EP
	EQodGzJFKrQUH5HKf0lBYrXGvjTH5O1Bz39zwn+KO/Z7VxZfSh8IPw7H1bfFoYQQkcTVTOgUsh1
	UJ3hXgnELTxJnDCwAt97mxmfC2LfOF3uPRmo/pVdWlptbjV2v6kuS+vKbmIKyFrZCRU7OnHtG87
	YnDc7u5a4fTiprzu/HMI/3DGRg7MOd0/DSNbs3DIMYuX+pjKfLoJhxPA+HpvtdHW1yW6OYtfp
X-Received: by 2002:a05:6122:3c45:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5ecc43a4d30mr2895214e0c.4.1794071592253;
        Sat, 07 Nov 2026 09:13:12 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64ccb58sm4015495e0c.9.2026.11.07.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:13:10 -0800 (PST)
Date: Sat, 07 Nov 2026 12:13:09 -0500
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
Message-ID: <willemdebruijn.kernel.2b153da88ae03@gmail.com>
In-Reply-To: <20261107162649.282982-1-skalpesh942@gmail.com>
References: <20261107162649.282982-1-skalpesh942@gmail.com>
Subject: Re: [PATCH net v3] tun: disallow setting IEEE 802.15.4 and 6LoWPAN
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
> ARPHRD_6LOWPAN via TUNSETLINK by returning -EINVAL.
> 
> Fixes: cca8ea3b05c9 ("net: tun: set tun->dev->addr_len during TUNSETLINK processing")

Should this be

Fixes: ff4cc3ac93e1 ("[TUNTAP]: Allow setting the linktype of the tap device from userspace")

> Reported-by: syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9ea34da5ca6100593c90
> Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
> ---
> v2 -> v3:
> - Include ARPHRD_6LOWPAN alongside ARPHRD_IEEE802154 as agreed with Willem
>   de Bruijn, preventing Sashiko AI flags and addressing the underlying
>   lowpan_dev(dev) memory corruption.
> - Minimize code churn as advised by Willem de Bruijn: drop unrelated
>   USHRT_MAX check and preserve tun_get_addr_len(), headers, and existing
>   block indentation.
> - Fresh standalone thread as advised by Jakub Kicinski.
> - Link to v1 and v2 discussion:
>   https://lore.kernel.org/all/20261101092219.1278751-1-skalpesh942@gmail.com/
> 
> v1 -> v2:
> - Instead of adding NULL checks in net/ieee802154/nl-mac.c, disallow setting
>   ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR link types via TUNSETLINK in
>   drivers/net/tun.c, as discussed with Andrew Lunn and identified in Sashiko
>   bot review. Virtual IEEE 802.15.4 interfaces are properly provided by
>   mac802154_hwsim and fakelb; TUN devices cannot function as genuine 802.15.4
>   radios and lack private 802.15.4 contexts.
> - Add an explicit bounds check (arg > USHRT_MAX) to prevent integer truncation
>   bypasses when casting 64-bit ioctl arg to 16-bit dev->type.
> - Remove ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR from tun_get_addr_len()
>   and drop unused <linux/ieee802154.h> header.
> 
>  drivers/net/tun.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e60..05eb28578b8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3362,6 +3362,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			netif_info(tun, drv, tun->dev,
>  				   "Linktype set failed because interface is up\n");
>  			ret = -EBUSY;
> +		} else if (arg == ARPHRD_IEEE802154 ||
> +			   arg == ARPHRD_IEEE802154_MONITOR ||
> +			   arg == ARPHRD_6LOWPAN) {
> +			ret = -EINVAL;

Thanks, a lot simpler.

But, arg is unsigned long while tun->dev->type is unsigned short.

An arg ARPHRD_IEEE802154 | 0x10000 could pass this check, get and get
assigned while truncated.

Cast to unsigned short in these comparisons?

>  		} else {
>  			ret = call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE,
>  						       tun->dev);
> -- 
> 2.53.0
> 


