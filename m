Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275616DEB4;
	Wed, 13 Nov 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495518; cv=none; b=oHKbpNZhgfi+pYkNRj0oSUl5vPvIzj35juQmJOOxVoKiAzWPAv9MNM0BtqEe+zSefyS1bRG9Mo+jDZYKKZVg3qKSU1dzUcEBNzyWIefijeA7Kg7QR3S6xO+VVfJvZzdKo05k4eEMxlTkZqZRG4HDSEgRDYJSI+zpJ+8PSCwBIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495518; c=relaxed/simple;
	bh=6Hy5CkeqkSRyDOyHXRUsGDei8gwVLDkAXj3QloX6GUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LqFBlAoFNsAdklTh4beplPcjTFPqt7LhzxGcL/Y2fH513wxekcjdTmMKRTJLLCuBb17lbyYlSSu0r8njMYCE+LNWBQerYYZyLXSgyd+ziKJEVmvzivjjDA0TQI+6ZviNxXwdjo6CN47UQNAfkDvPAiazSzltb3xbDkcqQg0ySBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EGKIz3Lk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EGKIz3Lk"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D7D5240007;
	Wed, 13 Nov 2024 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731495513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg8EcxP9c4X3W4Nj4W3qa+pEmtPxAc2YrxDIBvx5Rnc=;
	b=EGKIz3LkZogapQJ1Wjd1cqMx1yenl4an+h7+CVWcfrOmP4o6aD8RuCHlBgdBjjP+ensgjP
	TS4Gp+owsFeMAqbfKnX/Dlvg0es+hdg4RiXkpX+dEDY1Y2UT6SCde5eZh2sABeUknzFE4w
	s7SMpCfcQlXmZeW4LVNQVZpVCIpsY3r59hAy0ORLspnRkHiWCOPXkCMG1bNroIM6iU5ujB
	RAXkUg1S1a2nWKKPNhpP0l5Q7rN4J0P/sImXnxPgqxxbxZ2VCBayLJ6Na2NSufpdN1RzFA
	4WlPj2lLsb6GjR7ruTZfejajnIthfhj3ldQSF/6qijo1hiZcr5HymoyCaCxX1A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Lizhi Xu <lizhi.xu@windriver.com>,  alex.aring@gmail.com,
  davem@davemloft.net,  edumazet@google.com,  horms@kernel.org,
  kuba@kernel.org,  linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org,  linux-wpan@vger.kernel.org,
  netdev@vger.kernel.org,  pabeni@redhat.com,  stefan@datenfreihafen.org,
  syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com,
  syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mac802154: add a check for slave data list before delete
In-Reply-To: <6ff1052f-76d5-42a4-bf0c-ec587ca4faa4@yandex.ru> (Dmitry
	Antipov's message of "Wed, 13 Nov 2024 13:29:55 +0300")
References: <87a5e4u35q.fsf@bootlin.com>
	<20241112134145.959501-1-lizhi.xu@windriver.com>
	<6ff1052f-76d5-42a4-bf0c-ec587ca4faa4@yandex.ru>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 13 Nov 2024 11:58:32 +0100
Message-ID: <87y11npfhj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 13/11/2024 at 13:29:55 +03, Dmitry Antipov <dmantipov@yandex.ru> wrote:

> On 11/12/24 4:41 PM, Lizhi Xu wrote:
>
>>   	mutex_lock(&sdata->local->iflist_mtx);
>> +	if (list_empty(&sdata->local->interfaces)) {
>> +		mutex_unlock(&sdata->local->iflist_mtx);
>> +		return;
>> +	}
>>   	list_del_rcu(&sdata->list);
>>   	mutex_unlock(&sdata->local->iflist_mtx);
>
> Note https://syzkaller.appspot.com/text?tag=3DReproC&x=3D12a9f740580000 m=
akes an
> attempt to connect the only device. How this is expected to work if there=
 are
> more than one device?

Isn't sdata already specific enough? What do you mean by "device"?

Thanks,
Miqu=C3=A8l
