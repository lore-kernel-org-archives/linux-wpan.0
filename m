Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB613C3F2
	for <linux-wpan@vger.kernel.org>; Wed, 24 Sep 2025 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674079; cv=pass; b=GnLSZxuoxKs7GZK9w02eT9fTt1NxxS3yS96NrBGWsaF9CBJZhp9tuXyqfeOnYrmJdUfJdIcLXOo3wi0YXlHRqP3CDb1WVzb9InHYiH6cTejC7A3O8D3aydXFLE4YKdhoiiP0/eu6EEmqRla2JNXpQbcu61wmt+oJ8TgOvcF96Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674079; c=relaxed/simple;
	bh=j+eotSuHpnN4g+1i6jUoAX8BftZrtYBXWwnBzaM/3Ck=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=VuWJtaCrewPiNB7fHi/qQj0SadC1aeKOKy8BOajF7vjw9YmQ3mGyAC/rissG+KLrDbi/bVghefdyPI829YnNv41y7PDU0H/nubJ9eiv+gDx1ZxAKpb+2KkO2luGSs09FeoViBdfVe5iRR96GTPRFUORCWrdJbO2JLUE4jeqAJnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=F75wxKV9; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="F75wxKV9"
ARC-Seal: i=1; a=rsa-sha256; t=1758674077; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=B12k7G/p5Bu4x+uNMruwuCEUtzzuuNv5dXO0SUTqTUSk8lU7jzKmI2/FDz6ZBdXsj1UIARk+Nv85mAVddWWfRmnOFYuwpU0gulpr3bC2kudTwqy5OCXT+BBhi+mvW9fOxdmCCKF0IRyqAphlDDcxnm5Cu2gUgGCTIPn9AZBqE8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674077; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=j+eotSuHpnN4g+1i6jUoAX8BftZrtYBXWwnBzaM/3Ck=; 
	b=XYFkYhV8djkMUPEHobJuxsPhKIsyz2pIFHbFBAEiiBFN2ssqZBXXAYausDG55RhF8st2jk6R2s1GLxxray4QQljgJslCBaHuGh8MdvSze2TemjylgS2n++rbCELc6TmwZuvfCPHHNjbcOA7sk7jJnnj6yt0sptX2Cv+lQPMHUNg=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9ac672a0-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 175867165343671.40932547301634;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=F75wxKV9sv2RtUIkuOh5hy96NOzcGOSCpE9lPrMbG49d24SZEu5fRh8pr+cdcrT0Yv18//E6fw5+s9qMqDtdexhrvxdCirpzV/vsaRYLSL3ZkkiQlJdCkkqmDb4DTPU4aPpKPm1nyp6exsEt01lg9PJLVxWl1RO4zcLaW31PiSA=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=j+eotSuHpnN4g+1i6jUoAX8BftZrtYBXWwnBzaM/3Ck=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-wpan@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9ac672a0-98d8-11f0-9ce0-52540088df93.19978ffc6ca@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9ac672a0-98d8-11f0-9ce0-52540088df93.19978ffc6ca
X-JID: 2d6f.1aedd99b146bc1ac.s1.9ac672a0-98d8-11f0-9ce0-52540088df93.19978ffc6ca
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9ac672a0-98d8-11f0-9ce0-52540088df93.19978ffc6ca
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9ac672a0-98d8-11f0-9ce0-52540088df93.19978ffc6ca
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9ac672a0-98d8-11f0-9ce0-52540088df93.19978ffc6ca@zeptomail.com>
X-ZohoMailClient: External

To: linux-wpan@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
