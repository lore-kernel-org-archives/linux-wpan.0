Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772965;
	b=o5FRvA0fxur2ZH0Lm5Lgdv2tJ9lINcdnbjOVN6A/O+MfvIstD4Z+m3E7a/tP7u2TXXBS
	 dl42GB6SZrj+koUzA1xK4D5lTlgC1MNcYhMZ3WDiBeSZe1UcUlCcHoX+imowls5lXVKWY
	 SXSn1TT1vIvIZNmvqGROGAa3uRy/01dt57WFkxk0qFYG9bxFVOGY4pu49dZisDnh0039x
	 siAFvZq3S4NbT/ruUrx9Pw5WhzzO2ytFuH6C/t1kR+ck61BCK15y6c6PC7xHPCeABF6a8
	 uq32FVuCQe8v4c34L0KUC5fND4kbWbK9BbaCacq352wOp+nzueTeuJYkX3pyNwhGuyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772965;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Vd7ZQm1Iub6VBWC9SEDsd/uEgDH56WnOYPS/1GTzNX0=;
	b=0nT2gUIgVi/xBCTbz9Nv1mXOiqnjh8phZ8NcR5DlQClk6noeJfZ+lALqCKb4c0FusFKo
	 lYNy7SogQAfxqrNz7W/+ffmWs7LabO3sNesv8qBc8MsAgj7ZwPGZSENs5Qmldznx27goo
	 5jTtzBj1k8adiRGpRfgpIbnDfz1+n/FlqbeC+/wm81yWGkX5OJVgjYZ5t7t7PIa1FfK2t
	 ngNaCOMHwyCB5ROeY9He2AeCnYFDxePTM98XMrDdnWFt8UJDgxzvADIDxK0gaG2l11irR
	 f7+qU8luSgqYsrW/krQRswScdyLlEvCnWj56o9eGXRCZjs9yvCWxSdCJBL4IR8AExZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	dkim=pass header.d=datenfreihafen.org header.i=@datenfreihafen.org header.a=rsa-sha256 header.s=2021 header.b=kuIe27Rk;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B6606A31C;
	Fri, 27 Nov 2026 09:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E81B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.a=rsa-sha256 header.s=2021 header.b=kuIe27Rk
Received: from [192.168.2.30] (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 9258AC03CB;
	Fri, 27 Nov 2026 10:49:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1795772955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd7ZQm1Iub6VBWC9SEDsd/uEgDH56WnOYPS/1GTzNX0=;
	b=kuIe27Rk37jREZkdWxM1emblDWN6XmlzvqdZ9n8DQpziqtDucavvfStVCVRNszuYLLu1k/
	o9u5LbEUvfAtvLqRA+MJ0wQ9UxsEPVxMAXE6jC6ft/dREA2RoWwpFyHOQhFtrsArdfDCNk
	sH+4cY/+7GVKDQ9zhsP6Syyd2Hlh8LXAVGu0S/66VPKAcxKNcM/q4yZUlW+YZ529rg/j71
	MKlHglwY/fQmRF8G51m8Q9AnV5KkmUS/PdlgDhgE/X2CijCg7VS+VA6vDTLI3TiPbEeW/O
	H9Fl9etRvKHtCrth/2GJlvg+XBoDm87rmQxPaRGtNf9PTW0alnLV+8dNX6jp6w==
Message-ID: <9609d9b9-9dfa-40bd-8d67-27a7f8d64806@datenfreihafen.org>
Date: Fri, 27 Nov 2026 10:49:14 +0100
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac802154: Cancel scan work synchronously during hardware
 teardown
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Aryan Arora <aryanarora.w1@gmail.com>,
 Alexander Aring <alex.aring@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Girault <david.girault@qorvo.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
 <87v77626rq.fsf@bootlin.com> <20261019190736.33bc37e6@kernel.org>
 <87a4n8rczw.fsf@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Content-Language: en-US
In-Reply-To: <87a4n8rczw.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub, Miquel, Alex,

On 11/16/26 16:51, Miquel Raynal wrote:
> On 19/10/2026 at 19:07:36 -07, Jakub Kicinski <kuba@kernel.org> wrote:
> 
>> On Mon, 12 Oct 2026 19:00:41 +0200 Miquel Raynal wrote:
>>> I thought this had already been fixed but apparently not.
>>
>> FWIW / in case it's falling thru the cracks - we're expecting Stefan
>> to pick up mac802154 patches. Please shout if that's incorrect.
> 
> Stefan will probably explain it better than me, but he has been our main
> "sink point" :-) and has been handling the pull requests for many
> years. Unfortunately he reached out to us recently stating that he was
> lacking time for the maintainance.

Indeed. Very obviously I have been missing in action on this role again 
and again. Reality is that I simply do not have the time for this 
anymore. :/ Time to hand over.

I sent a pull request yesterday with some of the pending patches that 
had been reviewed by Miquel already.

There is another one coming up next week. (currently ~30 patches pending 
in patchwork). Once I am done through them I will send my last pull 
request. And afterwards the removal from MAINTAINERS.

> Right now there is a bit of backlog since I was off the past weeks, I am
> catching up on the ieee/mac802154 reviews (except llsec and 6lowpan,
> where Alexander has a lot more knowledge).
> 
> I believe the flow that works best is if you (net maintainers)
> "continue" applying the patches directly, especially since these days
> there are only AI bug fixes. We can definitely re-instate a formal
> pull-request relationship between us as soon as there are new "features"
> being discussed. We (wpan folks) will do our best to respond with timely
> feedback/reviews.

As you already discussed it would be good if Alex and Miquel review for 
their respective areas, add the tag and net team picks up the fixes 
directly into the net tree.  Miquel also already offered pull-request 
for new functionality and bigger changes, when they appear.

Thanks to everyone taking on some of these!

regards
Stefan Schmidt

