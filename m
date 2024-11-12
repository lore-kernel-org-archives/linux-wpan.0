Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9E1F77A7;
	Tue, 12 Nov 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409293; cv=none; b=hYqgRMS0iqQxydKRQ58aLloY6SQI9RVCyAryIeZ7aWEtpJ4i8+YTRGgMilxg7SsV4zX8gQX1yvhEZp/JnQwh4VH7PLxZh2lnHEntSn/cRHaZgW6AgTo1k/gbfGOzpqJgK+t5AT2HuECAf9c9in8Ilh2XYze5RURDqoIrGK71fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409293; c=relaxed/simple;
	bh=A/1yp0LaJZZY/+agPEY0mYZ96StMCvDdlakH86oaiKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JOuCvYc7L8tD2npllVgSSviJ2HC3BsOFZlTipq/bihF7yN3uc1KrCzQC31Z5sv74k7ONNm9FudBNUsomQB6WTpP6STJUwSvy0Y+v7sFfmcfTdK6nQToK6FoQqcCt8GQ1IcG0zm5MRff2wvJWMaDXm7y/E1GfOYglff6BfzyQ1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CUyFtoHF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CUyFtoHF"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38001240011;
	Tue, 12 Nov 2024 11:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731409283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osagrrumfDGl8S19V6hpWE8fnqHAIqSNeF5380MEu3w=;
	b=CUyFtoHF/08sM1eEggzqP7IJe6O8R0TkpW63Bs9QPbEdltpEwqx575feeKDvJIgjExRxu3
	S58bXqI/Fj8kpAt8YxV2ziwbVUsg4FlPj0VGcqr7rlpTal2QUPme2eDLdB9kA7cURMN91e
	QE5SagNWrT2yPA7s6OpZS+2GegGVlbaiawgxOYKVCvHX3RkOa5drKDAwjcIsIjpej1LcXp
	mZcddRk18xaXwz269r4UdXdckjewdoNEExtNIHl50eu0UCwTkrTkTHKj7E3TleHq+VTeYF
	AWYg+8wZTVjqZz1phg+9KSXGxV8QsyY1eheqFBVjP4mC4by7oORFMmrW9gBXrg==
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
In-Reply-To: <20241112002134.2003089-1-lizhi.xu@windriver.com> (Lizhi Xu's
	message of "Tue, 12 Nov 2024 08:21:33 +0800")
References: <87msi5pn7y.fsf@bootlin.com>
	<20241112002134.2003089-1-lizhi.xu@windriver.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Tue, 12 Nov 2024 12:01:21 +0100
Message-ID: <87a5e4u35q.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 12/11/2024 at 08:21:33 +08, Lizhi Xu <lizhi.xu@windriver.com> wrote:

> On Mon, 11 Nov 2024 20:46:57 +0100, Miquel Raynal wrote:
>> On 08/11/2024 at 22:54:20 +08, Lizhi Xu <lizhi.xu@windriver.com> wrote:
>>=20
>> > syzkaller reported a corrupted list in ieee802154_if_remove. [1]
>> >
>> > Remove an IEEE 802.15.4 network interface after unregister an IEEE 802=
.15.4
>> > hardware device from the system.
>> >
>> > CPU0					CPU1
>> > =3D=3D=3D=3D					=3D=3D=3D=3D
>> > genl_family_rcv_msg_doit		ieee802154_unregister_hw
>> > ieee802154_del_iface			ieee802154_remove_interfaces
>> > rdev_del_virtual_intf_deprecated	list_del(&sdata->list)
>> > ieee802154_if_remove
>> > list_del_rcu
>>=20
>> FYI this is a "duplicate" but with a different approach than:
>> https://lore.kernel.org/linux-wpan/87v7wtpngj.fsf@bootlin.com/T/#m02cebe=
86ec0171fc4d3350676bbdd4a7e3827077
> No, my patch was the first to fix it, someone else copied my
> patch. Here is my patch:

Ok, so same question as to the other contributor, why not enclosing the
remaining list_del_rcu() within mutex protection? Can we avoid the
creation of the LISTDONE state bit?

Thanks,
Miqu=C3=A8l
