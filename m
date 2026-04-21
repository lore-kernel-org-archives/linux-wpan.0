Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902114A8B;
	Tue, 21 Apr 2026 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764862; cv=none; b=ALITT/v0InG9/ovhLmngrqBD7ZPGSewYnJm2hdfHoSzHDs2EkMyYSk9Ej2Ny5FT/B635X+QFsuHcnEZOB8gvY3ORJVRqjBDpdr7nWIlKUKqpJlwcyF4/wj+EOGbWSj/2Y3/e+nizR7PaEqOfSs9qBBc6eFvT7Mf1QbaVJolb3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764862; c=relaxed/simple;
	bh=MhHUusRuKE3zk9CwwZvADgx4f2L4Pm6uGVqeYkH3DLg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=W24GsLIloZQqpYmSBTR7Bhh8r5Gq8bsZa+pKpPdgqvzCczbs5QvRslVpESiLcJyVeFzXVGjS2ysqyrEmSodqq8wYO80WQ+wJH5EmkQRI6Y7jmq27M4LD2TGTB+jftKZcZNB3ea4I+slwECjHkzMoj3rVd2MdL+VFU1WXjytHFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Q4JS/KOa; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Q4JS/KOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1776764848; x=1777369648; i=markus.elfring@web.de;
	bh=ScR06nfgd/rjAYq8okr0K1/RBniFmMCWwZQYmk/Y+fc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q4JS/KOaoXE9wG8qkcuhKV09GwHKG0kYAD7eeKRAEj5/7scJE6oiCDF0UMradNVS
	 4ekpEWLdCTwj9ELjBbEkKSLGAkFbUTyllUywP2IXuoNPCBxGAfmHD/58y5eRjHRw6
	 Z5w/gkUjV5u61ALc6V1ZK/RJmCIEpmhDS/5g90yYJdEBu+WYC2OirA7grhbQ6odhv
	 Z1sFztEOj9UeThPXClVdPZ7J5Q0pqfmTuw8NYXvfLn1jDl9XwCtEZnOALrRSSQTXm
	 1giHk+nqDeCjK8PFj3jEuLq/ei68raVoGQaqO4ND0pakDx/2qRVXNzR7km7nAgFL0
	 31Zrwyk8jR2DOgvKPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1vRz3T3ARv-013h2Q; Tue, 21
 Apr 2026 11:47:28 +0200
Message-ID: <6ef93306-d29b-49f2-88ed-b0ef3561a487@web.de>
Date: Tue, 21 Apr 2026 11:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Shitalkumar Gandhi <shital.gandhi45@gmail.com>, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/ehXVDDefBgHWziC2h70E+iFIc7pBIAy23eNHvgti1UnOg7Q7Q
 U+eZasZb8SDAnuP9iSpoA2IJAzLM00pBzZxnegF8O3KFamGlbhD6rTfkM9soqSsY+lkcPK2
 n7c1P/NtH74zCumhOnzOLWtGXKPAcOw6Pt1+eprW6+x2ZqG56xaxD3LaTKmsDLZ5btks90G
 Bs1zbhd3l+Y5C+iYmLc0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FuFxkSUx9Kg=;jmpMef6/wurprVEecrKjgpt0De+
 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
 mqqCvhU73vd2E4Q==

=E2=80=A6
> Fix it by freeing cas_ctl on the spi_async() error path.  While here,
> correct the misleading error string: the function calls spi_async(),
> not spi_sync().

Would it be safer to offer desired changes as separate patches?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.0#n81

Regards,
Markus
