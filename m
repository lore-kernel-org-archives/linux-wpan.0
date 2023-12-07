Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="wVsLL9xy"
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947D1713
	for <linux-wpan@vger.kernel.org>; Thu,  7 Dec 2023 12:55:47 -0800 (PST)
Received: from [IPV6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6] (p200300e9d7469cf9ea5593e02b2cf5b6.dip0.t-ipconnect.de [IPv6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 7A04DC05FB;
	Thu,  7 Dec 2023 21:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1701982545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLnY/07AQU2CjGfkV3jCf7/Px8FOYtFr+7mpZaA2HfQ=;
	b=wVsLL9xyW/3/WVRiqKVgK2LlqivjNpTVrXbhRoZq4ItgNvtuL1dPBbe3ux+mMKl7G6/ILC
	45KeCcxgRVuKWi9mqPYANtkKHnqgIJK8OTu9qB347lWE/vyj1+1G8X52lzINX2XAgnzRh4
	Igv/KFsszGiBGv/ozhPJzfPtbdaVIqUHLG0jUlWo8Z/9HGskLj1NFCPQbX8FAJRfYgiU+d
	UWrgIrGPL1+XMVNY164suLahoMQUGfhJQlBBpPau/fb4wRGvfIy+DMYrFlkeIi4qphdr9+
	Yg6b1WSlpgpDJ0L0gzNuAtpIyg2aR614QEzAWzr3OljQDMnNNa8i03snsDDesw==
Message-ID: <58d3e84b-1f48-9afa-6904-c2e4359d7b93@datenfreihafen.org>
Date: Thu, 7 Dec 2023 21:55:45 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wpan-tools] iwpan: Allow the phy shortcut for scanning
 commands
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: David Girault <david.girault@qorvo.com>,
 Romuald Despres <romuald.despres@qorvo.com>,
 Frederic Blain <frederic.blain@qorvo.com>,
 Nicolas Schodet <nico@ni.fr.eu.org>,
 Guilhem Imberton <guilhem.imberton@qorvo.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230213174703.1172423-1-miquel.raynal@bootlin.com>
 <20231128122714.10efea31@xps-13>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231128122714.10efea31@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 28.11.23 12:27, Miquel Raynal wrote:
> Hi Stefan,
> 
> miquel.raynal@bootlin.com wrote on Mon, 13 Feb 2023 18:47:03 +0100:
> 
>> Allow running:
>> iwpan phy <phy> scan trigger ...
>> iwpan phy <phy> scan abort ...
>>
>> Aside with the existing:
>> iwpan dev <dev> scan trigger ...
>> iwpan dev <dev> scan abort ...
>>
>> This change does not apply easily to the TOPLEVEL(scan) command, so we
>> keep this one more constrained for simplicity.
> 
> I believe this patch felt into the cracks, I think I remember it came
> from a request from Alex, maybe you will want to consider it for merge
> despite its "age"? Or maybe I missed some feedback in the SPAMS /o\

Nope, just fallen through the cracks. Applied now:

https://github.com/linux-wpan/wpan-tools/commit/3036dc0533abd6a89d5d0df0f3d9013aa294cbb3

regards
Stefan Schmidt
