Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66E3C416B
	for <linux-wpan@vger.kernel.org>; Mon, 31 Aug 2026 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163815; cv=none; b=KWEsExsy5QL9TEyuxB50/RRLa+HjNcH+cc7Cdqkd8wWz+i4oShAUuc4SiTMfj+bTYOBoK2uPN2Lrl8nKdIpV1+IDO2MuDENEs/xUTs0AmbRWgwZ31d70Eas0rma4JiIByU8uiU7FqrE9qu2ex56SGfd8TXYShJno8WJkhUn2qmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163815; c=relaxed/simple;
	bh=qYQr868TspaqhDv+OU2/m8jImwN84LFNUNtcGXo+i2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DxElXESggrVV/mQmxge9NGLSLfknZphICa3jWOWbpmA3y3bZUev+8eMe8+pCFT8CtlUWl8TTM10WkcRqdEc6qGS9uqxBiHIkFe3E6v4owazhZ9lqHfbtFiiR8vCUFiTd99rck/5MqZgdkOPsRsEfTl6oc2SDJViHgbRNzo1zys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KIC6t93O; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KIC6t93O"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3F3084E41469;
	Mon, 31 Aug 2026 08:10:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F2AD601E1;
	Mon, 31 Aug 2026 08:10:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9741511C783B9;
	Mon, 31 Aug 2026 10:10:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788163809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lf+jAuf1c//A6wiIx7V+m8/CTg8Q5h73hWBJwaRjx8w=;
	b=KIC6t93Oc9vRd95xZ1UTLfeTr8AjjKlziBcOI1lWZj/QypQKTcOiz3DFF4Kp07yRgeCUAs
	wbz96RZP5lES02y4VTL5TlEWY/gHSfdeUXnt6nf3MJEB34HLf1IphwGRZt9IsS6LBoN6GU
	7Ic+TPi7vkzKhuo1DlbRSsaozyKYOnXksYrpjv8dk8HA7W9GfrimAn9xAs1JtX4oMtfbG9
	fDc6eordKKxHmZApiV3tu1LAxq78GuaK4EMMj5tkXiJRsAM4j2UPCHFt2LuzmoRrw0FnP1
	S3/kPd5og766kN1BETi9Dw0vOOCcdVkwJVY9Xpc6U3o1oO+WhdhtlC+O4gj31w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  alex.aring@gmail.com,
  stefan@datenfreihafen.org,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,  Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] mac802154: drain mac_wq before unregistering
 interfaces
In-Reply-To: <20260828101905.26865-1-xuanqiang.luo@linux.dev> (Xuanqiang Luo's
	message of "Fri, 28 Aug 2026 18:19:05 +0800")
References: <20260828101905.26865-1-xuanqiang.luo@linux.dev>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 31 Aug 2026 10:10:05 +0200
Message-ID: <87jyp6btia.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 28/08/2026 at 18:19:05 +08, Xuanqiang Luo <xuanqiang.luo@linux.dev> wrot=
e:

> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> ieee802154_unregister_hw() unregisters the wpan netdevs before
> destroying mac_wq. The RX path stores the receiving sub-interface
> (sdata) in the queued MAC command descriptor without taking a
> reference to the netdev.
>
> If mac802154_rx_mac_cmd_worker() runs after the netdev has been freed,
> it dereferences the stale pointer and triggers a KASAN
> slab-use-after-free:
>
>   BUG: KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker+0xc0/0x4=
98 [mac802154]
>   Read of size 8 at addr ffff0000c6db0ba8 by task kworker/u16:3/61
>   ...
>   Call trace:
>    show_stack+0x20/0x38 (C)
>    dump_stack_lvl+0x78/0x90
>    print_address_description.constprop.0+0x88/0x398
>    print_report+0xa8/0x278
>    kasan_report+0xa8/0xf8
>    __asan_load8+0x9c/0xc0
>    mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
>    process_one_work+0x334/0x8b8
>   ...
>   Allocated by task 630:
>    kasan_save_stack+0x2c/0x58
>    kasan_save_track+0x20/0x40
>    kasan_save_alloc_info+0x40/0x58
>    __kasan_kmalloc+0xa0/0xb8
>    __kvmalloc_node_noprof+0x1e8/0x588
>    alloc_netdev_mqs+0x74/0x7f0
>    ieee802154_if_add+0xac/0x630 [mac802154]
>    ieee802154_register_hw+0x31c/0x3d0 [mac802154]
>    fakelb_add_one+0x250/0x318 [fakelb]
>   ...
>   Freed by task 652:
>    kasan_save_stack+0x2c/0x58
>    kasan_save_track+0x20/0x40
>    kasan_save_free_info+0x4c/0x78
>    __kasan_slab_free+0x60/0x90
>    kfree+0x194/0x478
>    kvfree+0x44/0x60
>    netdev_release+0x4c/0x68
>    device_release+0xac/0x130
>    kobject_cleanup+0x84/0x248
>    kobject_put+0x98/0xf8
>    netdev_run_todo+0x3a0/0x5e0
>    rtnl_unlock+0x18/0x30
>    ieee802154_unregister_hw+0x48/0x90 [mac802154]
>    fakelb_remove+0xe8/0x148 [fakelb]
>
> After killing local->tasklet, drain mac_wq before calling
> ieee802154_remove_interfaces() so pending work completes before the
> interfaces are unregistered. Do this without holding rtnl because scan
> and beacon workers acquire it themselves.
>
> Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Missing Cc: stable.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
