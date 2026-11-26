Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.47.171.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685458;
	b=O5HdfgXm/dCZlTdOnn94pP8HF+uY9JSvSZOosVeTR1hGwrysv1KBfSMkJ54+ZhJPwLZH
	 1o3gxlkvrIYjodRTwfpZhX4TP3Y/CAGJEwRa0LZBkjXl/7WNdIEW46dh+zOBjmbX05b85
	 IILuflUaKyjCf26pY1HtPICJZfsjBSUK1jvqy9lLez1ULPCQcC5bnf/6ZVCYiBq+g58Qy
	 R0gUweD7ntIcwM+raKki7fVm0cqQoKypR4fXG3lDJUcHriybqtiwlLeu/e6nJrk2mEdX5
	 Wmdxz8mp/MQ7yE9Nz/NlWNdMgiujOb2NvATs/u1kWelTGHn6FLXgBsyVfC+oWT+tP6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685458;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=476RQ3GYG4okDny442A7f62x9RH8CtxwgL2Y5IQAN4I=;
	b=Sl9ckr4+eVApRe10/BxC1nbDQCbibfkyBO34p2vzAko60dGcFo2hh68zKay6cz5PdI/X
	 7avPhK8WLgWFq4cbO0fRpEWudTxF6BFlmJgJHEK3+w3KTIqDl0sJzXnKshM3jBcIdaiB1
	 QlT7DsjOOWHRq7oy3nLWH/mKzj4ghZKwSvPGjor0L8dQ5lanf4REoatIE3op88FP3qfkK
	 omj/MLfw/GT7f26osZ4GBK05f4m/D1LAUpTChNfsSP2YukhenGTP68IkZB6YfC4eEYNiS
	 N0D+sNYhgSXUVop/Jnc2r7Sis9fd+WYiLNtTizVaTbLcRLl6AQ/998mkNLQgoGA+T7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=datenfreihafen.org;
	spf=pass smtp.mailfrom=datenfreihafen.org;
	arc=none smtp.remote-ip=78.47.171.185
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486A606A31C;
	Thu, 26 Nov 2026 09:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9486A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 63EC7C04A3;
	Thu, 26 Nov 2026 10:30:55 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrey Misiurov <amisiurov@cloudlinux.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ieee802154: keep the original error after a netns rollback
Date: Thu, 26 Nov 2026 10:30:50 +0100
Message-ID: <179568544756.1950988.3201920280564563921.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120065750.3274661-1-amisiurov@cloudlinux.com>
References: <20261120065750.3274661-1-amisiurov@cloudlinux.com>
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

Hello Andrey Misiurov.

On Fri, 20 Nov 2026 07:57:49 +0100, Andrey Misiurov wrote:
> cfg802154_switch_netns() moves all of a phy's netdevs into a new netns. If
> one move fails, it jumps to the errout label and moves the already-moved
> netdevs back to the old netns.
> 
> That rollback loop overwrites the same 'err' variable with the result of
> each move-back. The move-backs succeed, so 'err' ends up 0 and the function
> returns 0 -- success -- even though nothing moved and the phy stayed in the
> old netns. nl802154_wpan_phy_netns() then tells userspace the move worked.
> 
> [...]

Applied to wpan/wpan.git, thanks!

[1/1] ieee802154: keep the original error after a netns rollback
      https://git.kernel.org/wpan/wpan/c/006dfe9c1d68

regards,
Stefan Schmidt
