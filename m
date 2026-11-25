Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614364;
	b=fTOXQJUBnMmJKsV/8n2431bk0OzgPfF23mKr2WzZbFX2XNrP0CjFsVI6c//ASbtA4tKH
	 cze2Khy723bJiMW0a2r5TG5RJ+lEwPjzFdcgYl7dQfdec6zuTmq40tF5YRYTSidDroi6B
	 HzYfFi0Lq5XlrLieENHkJ/PgMZwWYMZWAfAXMVk+segXxpXlxq+mDb0KvO4kwvmx2HzyD
	 6uCjFBdBJTMnEcXmdxw8jrg3AD8z6vSwvf085v+W4Cjn2AgNIAcplh4ICsIlZg10uSroU
	 wP3fab2R0hagZ2tk8KPlgsDZlvLdIpEH9wzP8bsDhBkUsW26FtFhm8ldwub2wvLv6og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614364;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=b4sIt3pOcP2WjOnFWhiK5S5uXGqebYV48QQpOwEAHGs=;
	b=y+AAv25PQkmIsjPrOjWMkcy2WDnNYeS/WfGCpwjuCP5k+qf3lYSFTiAcFuMU6pFlJeZ+
	 ttPJZmOLaq0bDNwy3rl0mYI8tVuPQtUg4mbQaIzcrs29XykVpb5X065qg7Od+08ghBRLW
	 MKd9zCOBBLZo9ijdI4CF8VsV8UgOPpYxRUpdbokpNEI5MmaBp5MuY3lb0mRtXRpOlFWep
	 VMsnNjQraTKfY2rBnML0jTlYniO8WZLTtvKi0KYHzrGQFz9DoZmCcXDLGAB3+V9pvvmHG
	 xu00L7/9GY//UiBSHiDbuxE76OsOq3oWcsGQWxlo50S99DcIwWr0u5ndk1HZ24ot/uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=eX5o3CZI;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6E606A329
	for <linux-wpan@vger.kernel.org>; Wed, 25 Nov 2026 13:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D6E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=eX5o3CZI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CA3DCC69149
	for <linux-wpan@vger.kernel.org>; Wed, 25 Nov 2026 13:46:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0E4460480;
	Wed, 25 Nov 2026 13:46:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F228F11E6962E;
	Wed, 25 Nov 2026 14:45:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795614356; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=b4sIt3pOcP2WjOnFWhiK5S5uXGqebYV48QQpOwEAHGs=;
	b=eX5o3CZIhdaoEG7SBIuXiyNIp2/FOn04W3zIdJhd0/KmZJOAXp7Dn/k7TSNEBsrx1k/Q1p
	YEHmYAW+rvhJtqwGYibsjxDeIE9xPscX9SlzN8R8aZnrsmnLABckATdHvr1bJ963HoauEw
	/77p26hrno2soLoOr83TQj8FUxIPIq6TOjSmJ+OhDeqxcOvJL6JbchWR9AsdGtbRaTSWWC
	D4ssq0LOHDORXvnOIkhkCcDp5cRQ0r+bNSyzx6g+gmz+5cqkIYv9JfOCXLz2qc6QIQ7v+4
	/fMRTvXsE2zO7hiRkHvGfwtkacwYC14USs6v2V4a2v/fJue0eIT/RMenJTzjKw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lee Keon-Hyeong <leegun25@proton.me>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] mac802154: look up children by extended address
In-Reply-To: <20261124085905.710751-2-leegun25@proton.me> (Lee Keon-Hyeong's
	message of "Tue, 24 Nov 2026 08:59:21 +0000")
References: <20261124085905.710751-1-leegun25@proton.me>
	<20261124085905.710751-2-leegun25@proton.me>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Nov 2026 14:45:54 +0100
Message-ID: <877bi1yqgd.fsf@bootlin.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 24/11/2026 at 08:59:21 GMT, Lee Keon-Hyeong <leegun25@proton.me> wrote:

> The source address of an ASSOC REQ is always an extended address, but
> mac802154_process_association_req() builds the lookup key with the
> address mode chosen for the new child.  With alloc_addr=1 the new child
> has short-address mode, and cfg802154_pan_device_is_matching() rejects
> short-mode queries, so the lookup never matches.  Every retransmission
> is then appended as a new child, consuming an association slot and a
> short address.
>
> Look up the existing child by its extended address.
>
> With max_associations=2, two association requests from the same peer
> exhaust all available slots and prevent another peer from associating.
>
> I found this during an LLM-assisted code review and reproduced it with
> mac802154_hwsim.
>
> In a separate mac802154_hwsim test, 64 requests from the same peer
> left 64 child entries on the unpatched kernel.  With both patches
> applied, the same test left one entry.  Kernel selftests were not run.
>
> Fixes: 601f160b61b2 ("mac802154: Handle association requests from peers")
> Signed-off-by: Lee Keon-Hyeong <leegun25@proton.me>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
