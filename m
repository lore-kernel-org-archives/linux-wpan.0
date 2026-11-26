Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681706;
	b=bWEU7f9Bei6/a+P459hAlkMfAiyfxlB8q+DEVgBsnSgM6KJR8CfEqO6QeF60yh16lOd2
	 Z2IS8kObIeGMrBiNAh767/jMNoT5RoBG8iwhPweMbzfT9zbZNA4SWK07E+4lFdkRQcaUY
	 h1yfze6aYvtyc5HJX8bgk0nx3g31GZcxDOcGjBAUf11afFpTTkfQ9JANkpY+Ntm/UVKuG
	 64kk7xzczM5+C55xq5lTfyUHfEFFquP8UHZd4W1aXyAtCWComf6CNHhEb8UjsEfcEDDkn
	 Ofv2jq9HvoqxulOl/+G3/uVseycZ0V6EuBUyRi8z2ZWnVOCskUhzUtxaoJJMkA6y8Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681706;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xq0x4cTOUXhtJhfr87pihE2LGPwHYkhta0PSXMhDOWA=;
	b=FsdqUr1lPgntIm2aNyfhwPhNDBHvbJIf8KhZ78GLeqZGSufwKxh67n9butWE8+uPFh+p
	 qI3Wh3m6zTb2dNI8FQDFGnpVxAZboPVSHgoRwn7mcsgQxP6k6sL71k57fGNccppWBBqAv
	 kwssrv0knUm/BeqeuyL9O7Z/UYFZj7+yab0QKttdrzcTb7L/FoyH80mKB7FuXNctDJPhN
	 LRjWM/VDYxW/LQqhPem6G6exEvP8ZDTsCy56oIO9AeA+37CuR2ZMGMm9FgOPqZIw6KsXD
	 pm53wYiGCR3jkRzljwALXJR8ix4ijEUUs9rpocxoM3iY5zBlGO7t4CWHc5/9vnrPM0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460A1606A31C;
	Thu, 26 Nov 2026 08:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 460A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 43B2AC0368;
	Thu, 26 Nov 2026 09:28:24 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Aryan Arora <aryanarora.w1@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Girault <david.girault@qorvo.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+19cbce4cc656ecd4febc@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH] mac802154: Cancel scan work synchronously during hardware teardown
Date: Thu, 26 Nov 2026 09:28:18 +0100
Message-ID: <179568169335.1904157.8405124473303033794.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261012120934.64632-1-aryanarora.w1@gmail.com>
References: <20261012120934.64632-1-aryanarora.w1@gmail.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Aryan Arora.

On Mon, 12 Oct 2026 17:39:34 +0530, Aryan Arora wrote:
> Scan cleanup uses cancel_delayed_work(), which does not wait for a
> running scan worker. The worker can requeue itself after cancellation,
> leaving an active delayed-work timer when the PHY allocation is freed.
> 
> Cancel scan work synchronously before destroying the workqueue.
> 
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] mac802154: Cancel scan work synchronously during hardware teardown
      https://git.kernel.org/wpan/wpan/c/f89a03c1e1db

regards,
Stefan Schmidt
