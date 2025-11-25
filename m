Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403D32549B
	for <linux-wpan@vger.kernel.org>; Tue, 25 Nov 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083478; cv=none; b=jdz7oqCx0pcTxMeoOm3wgV/2yT6CwQRxAlasy2HasylYu3rGqxI8eLJEn5cdaimmvAulzruh6/6OeSUpVcVpOwGJgmtKDhvxrR8FW1qxlnuL0KI1X/ZnguF85EcxfBPMOHM56SQ5NLvCuMsWr72/XXgmCmkKzE/YSDI/LrXt1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083478; c=relaxed/simple;
	bh=ALizE41e8spcwDm7Lc9Zj0oPe7pc/w0Ah9V0zonHurI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I76Bq0FVS0XWjNqBvyeVfL6gGqRiH9QMYyy7Y+j/jl/aK8EGVApKOz7Px+zqFhmyl3BjpkynIeHawozMy4lMmSw/TDSePpZI0aX0UbtVtab6DDYWA0NydRyp5HSf9h2NsPwdgJhWgysymHHAkjoa99+XWAMGa/b/mGYy4X9V19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C2qa4/Yf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C2qa4/Yf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A68194E418BA;
	Tue, 25 Nov 2025 15:11:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65FE7606A1;
	Tue, 25 Nov 2025 15:11:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37607102F087D;
	Tue, 25 Nov 2025 16:11:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764083472; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ALizE41e8spcwDm7Lc9Zj0oPe7pc/w0Ah9V0zonHurI=;
	b=C2qa4/Yf4Ncwf5IsJRQGxuM99R7vUbWM/0KN9XwZLGNAdLhA5qpVZeb+SEwyXFebstR4EG
	Uaq1kiVDgS/60xtScYnE9ucq0ogFbnxywyul+Lb4fLFC60SM34IcHxOWOs8afkqSGFQboZ
	NCSrxqNDV01uVCUx1BMY2E2i/Pm5mrKK/60AzzTKMXPwgfkJ7Ld/9Mp7quDdb+Z/YCtBYQ
	F75PvbJzMVe1WwOGweA1SH3E3kSar60Lv0rrrmWjEX95KIZP2oJz8vv7qU6cSfQpSeT5du
	p8YcC8zDvcc0Uzb0oPCVAxraBQqc/uJveeHlGXVg3q+Yv4nMhQ9thtR1H5NdLw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Les Boys <lesboyspp43@outlook.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "alex.aring@gmail.com" <alex.aring@gmail.com>,
  "stefan@datenfreihafen.org" <stefan@datenfreihafen.org>
Subject: Re: [PATCH v1 2/2] net/ieee802154: use channel mask macros replace
 the hard-coded magic number
In-Reply-To: <SA2PR10MB44609D98484539F0A5948C8DA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
	(Les Boys's message of "Tue, 25 Nov 2025 09:41:30 +0000")
References: <SA2PR10MB446095FC84B7983FEB79DC40A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
	<SA2PR10MB4460A0469EEA025738C416D1A6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
	<SA2PR10MB44609D98484539F0A5948C8DA6D1A@SA2PR10MB4460.namprd10.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 25 Nov 2025 16:11:11 +0100
Message-ID: <87cy56uoz4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 25/11/2025 at 09:41:30 GMT, Les Boys <lesboyspp43@outlook.com> wrote:

> This commit replaced all the hard-coded magic numbers to macros defined in
> previous commit.

Can you please slightly rephrase into "Replace all the..."

Maybe the title can be shortened a little bit as well.

While I'm fine with this addition (I haven't checked all values), we
would need a proper name and Signed-off-by tag.

Thanks,
Miqu=C3=A8l
