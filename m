Received: from mail.growora.pl (mail.growora.pl [51.254.119.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3562CCA9
	for <linux-wpan@vger.kernel.org>; Fri, 27 Jun 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.254.119.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010395; cv=none; b=M7yCaisegIpmJAJrjDfLgO0Glgnq9vD57+oMiuLtpLxJVjLZYSgE2enhiNaT0cl5TIOVIJxMXEICB0ZX+erbBWZYcP+R2JKcUZEduv1arIoQw6hfckdwGJnepZ/931t7AIE6qmnfEMUfdprkU/KP7jkw5wrNhBIjDRemCQNOBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010395; c=relaxed/simple;
	bh=EB99enkNQ3/lKc2PdUObvM5/Gi3NF8gZrWwaTOp5KYs=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=D0FOkJgE5kWfta+GHriK+Z51t5J0ktohlqsojj92W4VpDXqtwi8hlzeoQRdxpOKSoaH4KyGFflFRxAD0SmVk3elFqMpewH1pamQGRLVd2KiokRwtT27+fwsiFZYLMbcZH+6IskrO4mKAanyXHfRxmi5ttD4QDpLo8T0iGhb5x64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl; spf=pass smtp.mailfrom=growora.pl; dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b=ejsAlbBq; arc=none smtp.client-ip=51.254.119.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growora.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b="ejsAlbBq"
Received: by mail.growora.pl (Postfix, from userid 1002)
	id F187223E4E; Fri, 27 Jun 2025 09:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growora.pl; s=mail;
	t=1751010385; bh=EB99enkNQ3/lKc2PdUObvM5/Gi3NF8gZrWwaTOp5KYs=;
	h=Date:From:To:Subject:From;
	b=ejsAlbBqSqDHhQrpRRK59FD48y3U9pgmwyx+AU3gi+oTHo5Msp6TJ7stxY88gFoLr
	 2QebR+yiEEQT14MASLZQ2ho2nHHNJ3LvKn0OYyH0rtYdGfbJ2mrrTRlemhNxktqskg
	 W7n/p6MvpI/XgQbxHDFTXzBdHpGZtKLZIqQqTsqe5twTXGsH29RNswyDDqhzTyzRBt
	 z2gpyQ6MVYzxap/ddosnHC2+LXtAA9h1vI78TxS/GUZBITEK9urBjMAjUBZxP3gs2M
	 QxtNsZ05hhenkG7gQ1FY77xNkLJchMqjutEPrnN/NvNFRKNi1KQeVtsyV9kvBKM4Fq
	 rmzc3BucKG7tQ==
Received: by mail.growora.pl for <linux-wpan@vger.kernel.org>; Fri, 27 Jun 2025 07:45:48 GMT
Message-ID: <20250627084500-0.1.ka.21kpd.0.8m11k7c11n@growora.pl>
Date: Fri, 27 Jun 2025 07:45:48 GMT
From: "Mateusz Hopczak" <mateusz.hopczak@growora.pl>
To: <linux-wpan@vger.kernel.org>
Subject: IT bez rekrutacji
X-Mailer: mail.growora.pl
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cze=C5=9B=C4=87,

wiem, =C5=BCe rozw=C3=B3j oprogramowania to dzi=C5=9B nie tylko kwestia t=
echnologii, ale tempa i dost=C4=99pno=C5=9Bci odpowiednich ludzi.=20

Je=C5=9Bli temat dotyczy r=C3=B3wnie=C5=BC Pa=C5=84stwa zespo=C5=82u, by=C4=
=87 mo=C5=BCe warto porozmawia=C4=87 o wsp=C3=B3=C5=82pracy, w kt=C3=B3re=
j to my przejmujemy ca=C5=82y proces tworzenia oprogramowania =E2=80=93 o=
d analizy po utrzymanie. Pracujemy elastycznie, dostosowuj=C4=85c si=C4=99=
 do wewn=C4=99trznych procedur i Waszego stacku technologicznego.

Dzia=C5=82amy tak, jakby=C5=9Bmy byli cz=C4=99=C5=9Bci=C4=85 zespo=C5=82u=
, ale bez operacyjnego ci=C4=99=C5=BCaru, ryzyka kosztownych rekrutacji, =
z elastycznym podej=C5=9Bciem i transparentnym modelem rozlicze=C5=84.

Czy jeste=C5=9Bcie Pa=C5=84stwo zainteresowani pog=C5=82=C4=99bieniem tem=
atu?


Pozdrawiam
Mateusz Hopczak
