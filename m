Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7D1B21B4;
	Wed, 26 Mar 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983933; cv=none; b=susMPni192nV5QuIt92IEOOytrlTrqMH+EqgsqP5Me9UxKBc5YoZxy3sUIsYl8fFF5+aQqveiqFyaTuu82WbbD7Do6EGWaTiXwBqCHO+bKP8uIrx+d48EA3bIJJgI3MJwKa2WOa8wpIwX7vNE9WjSUxSBaQdTKNwUZofII8ELvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983933; c=relaxed/simple;
	bh=q1ohoOoRigJG5BszVUpixxRxKWS2XGF2pVeV/7/Hxcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jeV+FKkLufnwmDDnkEQ51P1/vQFVQrjc8Gn15BWJauEb6ZrQBZyO8wKZHNBG9+2+yGHE0QJlvZ8JfSGsgrtlxE36Y0i8j+fcYW5mNAa2hMM0nKq9Z1Hj4D+1HPS2xRiyD1iPj/0+dj+JYNTR+ftJOriuRMKErji4t8efwEDQ7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TL7/8zl1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TL7/8zl1"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E747B433F0;
	Wed, 26 Mar 2025 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742983922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1ohoOoRigJG5BszVUpixxRxKWS2XGF2pVeV/7/Hxcg=;
	b=TL7/8zl1VMlxnGU0iUgG4lo6oyYL9bOqp3YJwJySnxZD4PuM8Ey+feDBN2QVqnndhCT/oP
	gtiyBuC/HXJbYWpcbN5/kHlj/GT4GEX8Y6+y4/KTbaqR3rR2/9mnWgah61+Yzh5aSMokC9
	2PSbgegEVvI9Qd+3+t9apcm2X4JcEpzQA4qtHekx0+noC92SxEMMz0zfXbPZjdL/MnJC8k
	iD8gzeUBk8X/Ks9WU5h2R4r6oKa9jHAH+TOm4fgO6F3G+CSMbEk+0miWmtuin1YGGvfSsi
	rGo/iWGI0o2AuBNL3WiNdqbQARY+SkNBmwxowIk3dTzpPoUiCUVi+ORXj8K/UA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net,  kuba@kernel.org,  pabeni@redhat.com,
  linux-wpan@vger.kernel.org,  alex.aring@gmail.com,
  netdev@vger.kernel.org
Subject: Re: [PATCH] mac802154_hwsim: define perm_extended_addr initialization
In-Reply-To: <20250325165312.26938-1-ramonreisfontes@gmail.com> (Ramon
	Fontes's message of "Tue, 25 Mar 2025 13:53:12 -0300")
References: <20250325165312.26938-1-ramonreisfontes@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Mar 2025 11:12:01 +0100
Message-ID: <87cye4qexa.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprhgrmhhonhhrvghishhfohhnthgvshesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqfihprghnsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepr
 ghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Ramon,

On 25/03/2025 at 13:53:12 -03, Ramon Fontes <ramonreisfontes@gmail.com> wro=
te:

> This establishes an initialization method for perm_extended_addr, alignin=
g it with the approach used in mac80211_hwsim.

You are now enforcing an (almost) static value, is that the intended
behaviour? If yes I would like a better explanation of why this is
relevant and how you picked eg. 0x02 as prefix to justify the change.

In general I am not opposed, even though I kind of liked the idea of
generating random addresses, especially since hwsim is not the only one
to do that and having a simulator that behaves like regular device
drivers actually makes sense IMO.

Also, please wrap the commit log.

> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>

Thanks,
Miqu=C3=A8l
