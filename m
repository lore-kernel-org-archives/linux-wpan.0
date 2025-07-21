Received: from mail.growora.pl (mail.growora.pl [51.254.119.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B381280A5A
	for <linux-wpan@vger.kernel.org>; Mon, 21 Jul 2025 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.254.119.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083419; cv=none; b=uKwDKui3JnywEv3tr6klhMQNlXDldV/RulPRjTNLdMyF+ujRR2vdP2Q0MyqiX8jTeZIy8LefOGk62Lbar993q7M5Nc5zCy/B+mchn1SFCq6nue6zOGYMXh+idDNqZu10CJomWfWDz19CiiWB+hVjJtVdpa1jopnYWobRIJqqjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083419; c=relaxed/simple;
	bh=RSy3akR1+Z0TK1MqUcCTAhuNDshd4oA9g7Cu4aFIABY=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=EKFkzwJ5Z2nzeMBMpoB+8/Xapqx99uLPox1bV5DMWWlBkk2MDlencpQAYwZpOCwSKnG4UYxdj5HBHpzenjxLmY1Tgr6WumPQ1Qi0Y+8Exbo4Gx7QVFhcvb2jOvrUjyaDX3ZeJcL5vVViLkl+lo5BLnC+YCtbgLZ+TpzS/2NdTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl; spf=pass smtp.mailfrom=growora.pl; dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b=ReH7cwo0; arc=none smtp.client-ip=51.254.119.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growora.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b="ReH7cwo0"
Received: by mail.growora.pl (Postfix, from userid 1002)
	id 656AB22D0C; Mon, 21 Jul 2025 09:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growora.pl; s=mail;
	t=1753083414; bh=RSy3akR1+Z0TK1MqUcCTAhuNDshd4oA9g7Cu4aFIABY=;
	h=Date:From:To:Subject:From;
	b=ReH7cwo0w6n3H+6GXyeJNCfDH+wVTuspE/p33ioywqzWa/vJvda2ijOoIN/+QGs3U
	 nij1pYO7NT2M5OJcmPlqa+GHWaPTZI7JR34sn4Cck8SDeLZdRBtztL0/r5oj11+21A
	 Hj3w5JNBF/ZBKGHDEyiIHv75UgKgSPWlDPy86PW/Env1rPJdL5MtwDcOIyuhx1bpHB
	 9/6oo/0d2eWhOeapEYrLWKh0Wvqp6/XhjRk+6ZpGP8ovUYSxa5JzzcEEw5SG91+kH3
	 U4gdjUHLKI8lgkaIcUIul2kGipxUgjnQK0U5CMR4RU+IO6QY9QdIi6m9Bmfruyf4y3
	 r4vMjcmfB91/g==
Received: by mail.growora.pl for <linux-wpan@vger.kernel.org>; Mon, 21 Jul 2025 07:35:59 GMT
Message-ID: <20250721084500-0.1.kq.29qdz.0.f711b273bx@growora.pl>
Date: Mon, 21 Jul 2025 07:35:59 GMT
From: "Mateusz Hopczak" <mateusz.hopczak@growora.pl>
To: <linux-wpan@vger.kernel.org>
Subject: Wsparcie programistyczne - termin spotkania 
X-Mailer: mail.growora.pl
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

czy w Pa=C5=84stwa firmie rozwa=C5=BCaj=C4=85 Pa=C5=84stwo rozw=C3=B3j no=
wego oprogramowania lub potrzebuj=C4=85 zaufanego zespo=C5=82u, kt=C3=B3r=
y przejmie odpowiedzialno=C5=9B=C4=87 za stron=C4=99 technologiczn=C4=85 =
projektu?

Jeste=C5=9Bmy butikowym software housem z 20-osobowym zespo=C5=82em in=C5=
=BCynier=C3=B3w. Specjalizujemy si=C4=99 w projektach high-tech i deeptec=
h =E2=80=93 od zaawansowanych system=C3=B3w AI/ML, przez blockchain i IoT=
, a=C5=BC po aplikacje mobilne, webowe i symulacyjne (m.in. Unreal Engine=
).

Wspieramy firmy technologiczne oraz startupy na r=C3=B3=C5=BCnych etapach=
: od koncepcji, przez development, po skalowanie i optymalizacj=C4=99. Dz=
ia=C5=82amy elastycznie =E2=80=93 jako partnerzy, podwykonawcy lub ventur=
e builderzy.

Je=C5=9Bli szukaj=C4=85 Pa=C5=84stwo zespo=C5=82u, kt=C3=B3ry rozumie z=C5=
=82o=C5=BCono=C5=9B=C4=87 projekt=C3=B3w i wnosi realn=C4=85 warto=C5=9B=C4=
=87 technologiczn=C4=85 =E2=80=93 ch=C4=99tnie porozmawiamy.

Czy mogliby=C5=9Bmy um=C3=B3wi=C4=87 si=C4=99 na kr=C3=B3tk=C4=85 rozmow=C4=
=99, by sprawdzi=C4=87 potencja=C5=82 wsp=C3=B3=C5=82pracy?


Z pozdrowieniami
Mateusz Hopczak
