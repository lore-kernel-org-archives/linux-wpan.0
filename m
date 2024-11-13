Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A5178CE4;
	Wed, 13 Nov 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486379; cv=none; b=Wha9CbKDXwUlbLDtoZzEfJl8KkFkS3B86rviAzYY8PA+z8IefVd+RzDs+531HZsSTTifWd7PrjkSN3LmBKhTU5Y3Ztnrkz9UfpZ6uROql3hQ+Yn7bTQo5Rm1PHycp8zmQseW2fZ2CKy9yl7/U1GWIR60SoClKghCja+KEoIsxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486379; c=relaxed/simple;
	bh=NDnMXOg3a/YTXToq46OO3ahs23cF1TL4Ssqae3WYPzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kqsXeizI4jqHoQdWjvRf2Dnta6EjMPl+giRa/WYvj9oz7/7Px1tAo7SOfHypwohfAp6hTbl/r73r2KTK2Kuq+Z5lo1q8QuWMjiUgkRge1OFh1HB64f57AfCFOmpTH9Mqc3JaSc5FNSgOqMK4FgQsqpDFZYhbjSEJMRRxkXAzuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ltgtRILT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ltgtRILT"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EFA0FF80B;
	Wed, 13 Nov 2024 08:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731486369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QL6WB2LZnSXEXRY0BOwCQ3u9d/gRvFiU2Qv5SmZq72A=;
	b=ltgtRILT2fq/g9aK/lshySY//LY+2Ylz1Vn/tDkPD4KgLVsA/6ikdHwCJbMz3Lfsm9co1u
	i/SbSWnB2qzJqFrb1FltAo2ZPBbjUU9iN2fQPEkBH1KOdokNl7U+kY8XZwvnDRdCmUmzab
	Ril1aRlNm5OUHA9fUT2YuokkfHbYrhbYIEVO0K9m46xl2+7Az1slh8GY7gFqiVehkXlvxs
	Up01h8QBDAVpiJTza0xXEzrMQHQD3qfiJsX1sA4UOcRROxkeHL/l0vzs/yojRElSVaM12F
	ZeggogdYBEI86ulquCJB8O3AZqileX6F5xvTP0yZItLmZy5nlpV+7DFk3zW+zQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <alex.aring@gmail.com>,  <davem@davemloft.net>,  <dmantipov@yandex.ru>,
  <edumazet@google.com>,  <horms@kernel.org>,  <kuba@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-usb@vger.kernel.org>,
  <linux-wpan@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <pabeni@redhat.com>,  <stefan@datenfreihafen.org>,
  <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>,
  <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] mac802154: add a check for slave data list before delete
In-Reply-To: <20241112134145.959501-1-lizhi.xu@windriver.com> (Lizhi Xu's
	message of "Tue, 12 Nov 2024 21:41:45 +0800")
References: <87a5e4u35q.fsf@bootlin.com>
	<20241112134145.959501-1-lizhi.xu@windriver.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 13 Nov 2024 09:26:07 +0100
Message-ID: <87plmzsfog.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 12/11/2024 at 21:41:45 +08, Lizhi Xu <lizhi.xu@windriver.com> wrote:

> On Tue, 12 Nov 2024 12:01:21 +0100, Miquel Raynal wrote:
>>On 12/11/2024 at 08:21:33 +08, Lizhi Xu <lizhi.xu@windriver.com> wrote:
>>
>>> On Mon, 11 Nov 2024 20:46:57 +0100, Miquel Raynal wrote:
>>>> On 08/11/2024 at 22:54:20 +08, Lizhi Xu <lizhi.xu@windriver.com> wrote:
>>>>
>>>> > syzkaller reported a corrupted list in ieee802154_if_remove. [1]
>>>> >
>>>> > Remove an IEEE 802.15.4 network interface after unregister an IEEE 8=
02.15.4
>>>> > hardware device from the system.
>>>> >
>>>> > CPU0					CPU1
>>>> > =3D=3D=3D=3D					=3D=3D=3D=3D
>>>> > genl_family_rcv_msg_doit		ieee802154_unregister_hw
>>>> > ieee802154_del_iface			ieee802154_remove_interfaces
>>>> > rdev_del_virtual_intf_deprecated	list_del(&sdata->list)
>>>> > ieee802154_if_remove
>>>> > list_del_rcu
>>>>
>>>> FYI this is a "duplicate" but with a different approach than:
>>>> https://lore.kernel.org/linux-wpan/87v7wtpngj.fsf@bootlin.com/T/#m02ce=
be86ec0171fc4d3350676bbdd4a7e3827077
>>> No, my patch was the first to fix it, someone else copied my
>>> patch. Here is my patch:
>>
>>Ok, so same question as to the other contributor, why not enclosing the
>>remaining list_del_rcu() within mutex protection? Can we avoid the
>>creation of the LISTDONE state bit?
> From the analysis of the list itself, we can not rely on the newly added =
state bit.=20
> The net device has been unregistered, since the rcu grace period,
> unregistration must be run before ieee802154_if_remove.
>
> Following is my V2 patch, it has been tested and works well.

Please send a proper v2, not an inline v2.

However the new approach looks better to me, so you can add my

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
