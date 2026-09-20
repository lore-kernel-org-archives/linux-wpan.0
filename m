Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C147DF94;
	Sun, 20 Sep 2026 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941040; cv=none; b=FhOz7oiatX+/DiVfmkX7qWkup9uZiSU/5ezaRAxV0YZQfkhThJau069IZGHiSUmXNN34sv+Vwr8FgTQ14/BJSpzx73O0HrH9eArNw85LXTEp+2N/7sPIk8rS3Lv+tyl2nUALpR5pczE5HUPYmvFMXZ3UwpCBwqRFYYNVyAluszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941040; c=relaxed/simple;
	bh=vAEDlOlaE9hxEllWauJno+Rj3sS//dyn+qJAfOKFz54=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JQCgJnxdHPZ42Khj1h0cltOs2jvp2gpeSzOkDOgY0abMKWju+Wdg09L3S2VcnVeh7DzYkIDnLbgM4RvnsyZFI342J4N76j+7uXQ/yVYKhp1A9dfbGJd2YgLCVGknM4KIpWDx2LBygq//cRrGV0N/xKJGmKDy/8/25c5/0iMfyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ARmWeqxt; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ARmWeqxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789941023; x=1790200223;
	bh=vAEDlOlaE9hxEllWauJno+Rj3sS//dyn+qJAfOKFz54=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ARmWeqxtCoLapPfWi4ue3DA8+6gg/UwyalZMhAU7atw6K0/bNfH9tBI5KavJcrOqO
	 tTDruQqALfRy4v7uK8tVAtGrlxoR05V4N9W3bCoJ92nWCE3j+vzCohzgPn5VciwI05
	 7vMdM5SflalcB+wUcCc9IGcEqNEwN8Ek13JUaX7OhqbQKuNrpf6VB8tzachOB3bMYc
	 jcTikKYR6y9os30U0xRBGPKjhD8Si54RUrKZMdHO6mZ3cZjqNvnoyjX1NS7eBf07aB
	 M1cCE2a1Ad0EkbW9raezy/OuulZQAzoy60vGs6a+KsZkDeNjtajqFkGqX3cG0R8BeS
	 avcI/fmtZa78A==
Date: Sun, 20 Sep 2026 21:50:17 +0000
To: "andrew@lunn.ch" <andrew@lunn.ch>
From: "i.n.a" <quiet-daffodil@proton.me>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC] Appropriate subsystem/UAPI for Semtech SX126x packet radio support
Message-ID: <blQUbzijkKTlQdGuLj0o-ZJ_Their5EXvu2RW5b0q-tuU0SBmwqMjpk6HprXKRq0Yn_RHathROFMQ3T8nnPaW3nrq9lQdwIG-cF6YaFIte4=@proton.me>
Feedback-ID: 199628520:user:proton
X-Pm-Message-ID: 1c5199131091546dd3b27db0e0d94a7fe5720ac9
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> You want to make whatever API you design vendor independent.

Thanks, that's a good point. I'll keep the API vendor-independent. Is there=
 an existing kernel abstraction you'd suggest as a starting point?

Thanks,
Ina
