Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="WF5eaCD6"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390C1713;
	Thu,  7 Dec 2023 12:28:03 -0800 (PST)
Received: from [IPV6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6] (p200300e9d7469cf9ea5593e02b2cf5b6.dip0.t-ipconnect.de [IPv6:2003:e9:d746:9cf9:ea55:93e0:2b2c:f5b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 2CD58C084A;
	Thu,  7 Dec 2023 21:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1701980880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knbgzvbIyj1cmWisBX7JA49IkOd+jI1IhNDx7hQJRXw=;
	b=WF5eaCD6TQKYAoG3ujF3p1lYGjqmYh6ZHW67phLCTPVxcnubR+KnTCnYSqS0znlejinwF9
	8FBkErzVSdnWYHrYelYNnN9L/jiVo3vjGFN2FyjHcylzdqqRcGQaUN7VAirYwblb5c89/N
	UjBOkVQ+SANmiQ8E4RMXEEneywL8Oqt5QPoSs91SsafKQkLaXmrjLpPJeb01Tdd3ffpWOe
	KT/HBydmZBskhIt8BPuaAuOBYCdhFK6XD+ZgW9RBhkjSDPTEQ1BMtI6JY+iX/89Sv1bZKW
	Sxy8m8g66wFaX1ZL9UL97qexz5+U/Z7gMwmGr5OTqMjtwHl3/hhOIxfkAx0gxQ==
Message-ID: <51de3b76-78cf-5ee4-ec31-6cf368b584b7@datenfreihafen.org>
Date: Thu, 7 Dec 2023 21:27:59 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wpan-next v5 01/11] ieee802154: Let PAN IDs be reset
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 David Girault <david.girault@qorvo.com>,
 Romuald Despres <romuald.despres@qorvo.com>,
 Frederic Blain <frederic.blain@qorvo.com>,
 Nicolas Schodet <nico@ni.fr.eu.org>,
 Guilhem Imberton <guilhem.imberton@qorvo.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231120110100.3808292-1-miquel.raynal@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20231120110100.3808292-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Miquel,


On 20.11.23 12:01, Miquel Raynal wrote:
> On Wed, 2023-09-27 at 18:12:04 UTC, Miquel Raynal wrote:
>> Soon association and disassociation will be implemented, which will
>> require to be able to either change the PAN ID from 0xFFFF to a real
>> value when association succeeded, or to reset the PAN ID to 0xFFFF upon
>> disassociation. Let's allow to do that manually for now.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging.

I can't see this, or any other patch from the series, in the staging 
branch. Did you forget to push this out to kernel.org?

regards
Stefan Schmidt
