Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="J+zAn52X"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E5E1715
	for <linux-wpan@vger.kernel.org>; Thu,  7 Dec 2023 13:04:58 -0800 (PST)
Received: from [IPV6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6] (p200300e9d7469cf9ea5593e02b2cf5b6.dip0.t-ipconnect.de [IPv6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id C84AAC0244;
	Thu,  7 Dec 2023 22:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1701983097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7GT0K3hA0Yvqln/aOf7VJI08Hden0WnWEFHIlqNIwds=;
	b=J+zAn52XCjZ82RGy6QXMIEXQ2NWT5Jp2L4+uNhVoG+tmad8SGOHaOiCcaDs4K7EqiYirb+
	+G3zrquhJZEm8mfCO00D/RX+qfEFO0ssnLboD2AnYZIsF2R0Zf+Jkbac5W50hYadmc8qJl
	sx1OiFY5m/Z0savA8Na2hxNgWFtHN1e18JNoU8IT0IOTOAQBri8nSWf0kiDv+kSQY1b2Qo
	LqWbjCrGY9pVSM8X69aACVuGb9oPhtSWmFcBcuArV5YXWfMj3Ar3I6pSng5COlprzQt7/C
	TsnW0o5MdOKehweOns7MZ8ODhn2h8dtcgsHpYeGKcHB3pqJ+U1ZQg5yO0oU60Q==
Message-ID: <521b3a2b-70eb-0eb1-c2fd-76c0fe7e207a@datenfreihafen.org>
Date: Thu, 7 Dec 2023 22:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wpan-tools 0/2] Associations support
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: David Girault <david.girault@qorvo.com>,
 Romuald Despres <romuald.despres@qorvo.com>,
 Frederic Blain <frederic.blain@qorvo.com>,
 Nicolas Schodet <nico@ni.fr.eu.org>,
 Guilhem Imberton <guilhem.imberton@qorvo.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231128112945.509331-1-miquel.raynal@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231128112945.509331-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

On 28.11.23 12:29, Miquel Raynal wrote:
> Hello,
> 
> Associations will be part of the next kernel merge window, so here is
> the userspace part to interact with it.
> 
> Thanks,
> Miquèl
> 
> Miquel Raynal (2):
>    iwpan: Synchronize nl802154.h with the latest association changes
>    iwpan: Add associations support
> 
>   src/info.c     |   4 ++
>   src/mac.c      | 187 +++++++++++++++++++++++++++++++++++++++++++++++++
>   src/nl802154.h |  22 +++++-
>   3 files changed, 211 insertions(+), 2 deletions(-)
> 

I pushed both of thee now into the associations-support topic branch of 
wpan-tools. Once A kernel is released with the support we can merge it 
into the main branch.

regards
Stefan Schmidt
