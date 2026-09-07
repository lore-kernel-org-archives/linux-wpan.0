Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157A495539
	for <linux-wpan@vger.kernel.org>; Mon,  7 Sep 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781333; cv=none; b=smwEiHDSzSRT8Y4zYfidhBPja0zj/XnLI4tAOBzzmv64F5SFxRaHNbmmE3RSgoyVllpSjk1Bglb7ZMPyi6VCAZecvWVcVu2vnvaqyvLrL4oVlZee7SyrxZCbBocEQgh1HT4AeyhqWpWCQDt38OQzDPZKEyKLKnway1yOoSOWI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781333; c=relaxed/simple;
	bh=C+eLPiFi9WdfK84iABK0goOyBk267bDzFYY1gpNX4aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ5F78MNWYqnpQDGZ4yst95qaYK1Lq0j6WTRqgH/fhkvHRCttYKq0OiZ5xUDOucSBm8FM4pMV4rWP5jZ2rAPeJNKih6HBT4Q9ROFFiq0xtrX26yz33mKDpAM1EZhkmgLbQcs1tZJx+A4D4T28+cHnWpRJSUHX+owWjjCFyNEFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atApHJdc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atApHJdc"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db59f54ccfso4817685ad.2
        for <linux-wpan@vger.kernel.org>; Mon, 07 Sep 2026 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788781331; x=1789386131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HFlAQzgEIbB8YVKSTeZ2MR1Rp9Uw4tUj/0oWZttTjE=;
        b=atApHJdcxcTPpV3AStHKq1VZy3IRPqVb1M4iIdEpSJwpjPlui0Nh8HHrrat/VbDlWl
         nsr5CAjnR4lbdYPJdMVFPvBP/gm1n7NorHhRqGxfDNYpYgZoY7/oR1HFJaIrf11hWJOX
         /s0FCWFkYnFkvYEML0biWszJezI8tq7dS5TZeHsZWCz8dX6ug+Ej5LZ+e0Uc5vB828Xx
         BlOzAqRkjPum7NIQBRqyWKvJBNZMG6OQhxNeOGmk+3gIcKzG/5tf1iSpUaE1HuOC0vEY
         6PqOz+6PlZj7Zy/ivlepE6Wb0qhF3poVC3aZuKg3jp5dVWtlXMynrgMXevwJGf5IiV+6
         uVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781331; x=1789386131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HFlAQzgEIbB8YVKSTeZ2MR1Rp9Uw4tUj/0oWZttTjE=;
        b=U3D2efyeSmwMgNlaIJXbCs7YQhCOlI4WY6NB7Tzdp/oLZd7j0JJDVlY9Bwo2k6R5dH
         xyo8btkP48tlFadpfDKqslJHvVCdv0vKOPK4yB5KkqwEZgLF3fBP034pudSm62vauep7
         f0/nuunqirH4h7tcKaf3BFw9UBF1tBwSOGPVxomfqXJyxf1QiT00lzO7xQWqM2JV5/Eu
         Jotey3wB0sFKbfu1ZWYJ1or8zcU8RkQbU3yVWb+G7J7pXwrDVFONjvL5AoVHyGPkQ4bU
         GtusuKAG34v3uj77vyNnGsKmY6HjkLLDSXHPirB+J0Ub/DEZn0/r7h0+KaaHPm72M9M7
         aYjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxq05dX0GK9Pdk34WxcIc5h4pzKiGIwzXOD9By4SrEpb/MonHbz9dQL0SGE/SdBqxexJev5+56bFCJr@vger.kernel.org
X-Gm-Message-State: AFuF++kbNrdaAj6TWatUqSr899l0tX+MaX5b3XcNlkhirZGLVS86HCIX
	i63+95B9VGqXBBov5cC/SVtQ1Rays0JhOUVfZfnDVs62ozVLjrHn0xoDFAuIBKdXS9Q=
X-Gm-Gg: AYBFou0D+1DQid2zdWyreIa1poztfPzzHI7KxtLQWf4AlNJsCi5Gbp4IrtDUUzP+Fk/
	p1NjpMcSKqCfMgj5EdKCvF1Afy7MQY3g3mnsEIVnb9k3MCt4g2L1ZWadOXbNNjo/LuhI4+ZybP8
	/qDo+ryIPwEXq1lyq68Og1eQ48T+6j6rn98HTtR+V6IZkxbHbz3bpJsLQ1YGWvPlFApxsgmgi1o
	ef5K9bThaIsXDMGLKWs+kgYf90ciMmygpP3amp5Iz2mWvSa5QCEDaiFWHZZBHsd+/XoYuBn/DdZ
	jQcOAGUDNycXu18dpeOv1iZSPMSoxAFZIlgpy2SObTfPv0pwCj848agoRkjjTLnghIMC8++rW0+
	5QahASP8cqdeysDstWfrk1P3KtYdfQsuK0y8pa1FeSiUQUoa0Lwd3BvoNJwjIr2Lojk81Oqv/GR
	owqivz6/i6VIbweo6xfy4wuCDLgybEcumiRWt4pT7fTT6jpFrZyNxCqgMWco2daubS6LO9fMFVL
	7mM8GyufMe86g==
X-Received: by 2002:a17:902:db09:b0:2db:5788:655d with SMTP id d9443c01a7336-2db57886668mr77258275ad.22.1788781330592;
        Mon, 07 Sep 2026 04:42:10 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33825669695sm5249874eec.3.2026.09.07.04.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:42:10 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wpan-next v2 0/2] ieee802154: fix typos in comments
Date: Mon,  7 Sep 2026 17:12:02 +0530
Message-ID: <20260907114203.40171-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <87pkypwf13.fsf@bootlin.com>
References: <20260907095132.21244-1-hemanth.selam@gmail.com> <87pkypwf13.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 07 Sep 2026, Miquel Raynal wrote:
> You should not have dropped my R-by tag though, given the fact that the
> diff is strictly identical.

You are right, and I am sorry.  The diff was unchanged, so your tag should
have been carried over.  I rebuilt the series from the commits rather than
from the posted patches and lost the trailer on the way; that is my
mistake, not something you should have had to chase.

Thanks for re-giving it, and for the note on the split.  I split by
component because maintainer-netdev.rst asks the prefix to name the code
being touched, and I could not see how to name both drivers/net/ieee802154
and net/mac802154 in one prefix.  Abusing the prefix is fine by me next
time.

I will not resend, as you asked.
