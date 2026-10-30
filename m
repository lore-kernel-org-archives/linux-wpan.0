Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353078;
	b=v9o8J2NMe+CP9UtTAxU20fqZBQpm4SeWyR11CrXQXzKzgHsuJ+RhMuaF0gvnmeNpsXdi
	 7APLTFjU/EkQ6pvFGEH6ud3XgF3MbK0GmaRDmK0FejReFENxiWIJ123OUaR0pQVDf40wc
	 Iw+tyggWm298p9L1qh6Khc4gnJnNma3y4xx9wCunUHOZVNtPBZ7KRSOfGJpZTU0hcaDkG
	 5zeyFTsc8/SkqJwHsXQTGDa1LiHeRDgfneRXZBAkLd7y7uWKLsd+XeZvubOPR+yg5RGI9
	 zSzJxAncPJkedpZyMP94CPcDMSBEt1h7SlLGghlIuXJkzruwdaYMoS8wS6SLC9yvk7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353078;
	h=DMARC-Filter:Received:From:Date:Message-ID:To:Cc:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=+y5ZcTSYD9voa3trTxpiYMMRe0qIdmly2cME/iyq9dQ=;
	b=UIeME62OOMsssJbBqoH4Dr6rhh+JJMCNwqF44325hSNqeNwINrd7qNbN/RQ970t5JgOH
	 jl1Xz84A/MWA81EDKDHhONQVNdiHGPlawUeFoAxMETLHkZ75fIkifXB9x4uPZZgM9AULN
	 LYx/tOYT33we77OBjbgCF3EXrH7DfHycCUB/oLn3xRjNFd0NbtUEZjcVRh76PLQ0SdD5J
	 abcHhOl6gJn34ggFBzBcUziUZJwkk5TvDcE0RoVbwBgHBJt/e/DzO62uciFN628L6pzcx
	 VxYl0qJdyuD2JlLFSzGhXyk3pk86DEV4IJpd3vsCpd4gSBRX0GVFzTX7LP8vGoW34zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=bmghQLpg;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B465606A31A
	for <linux-wpan@vger.kernel.org>; Fri, 30 Oct 2026 09:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B465606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=bmghQLpg
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [61.37.18.93])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52eda3c3e;
	Fri, 30 Oct 2026 17:37:52 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Date: Fri, 30 Oct 2026 17:37:51 +0800
Message-ID: <179335307171.15530.11058404394408918540@stu.pku.edu.cn>
To: miquel.raynal@bootlin.com
Cc:
 linux-wpan@vger.kernel.org, alex.aring@gmail.com, stefan@datenfreihafen.org
Subject: Re: [BUG] mac802154: beacon interface switch can cause a netdev
 use-after-free
In-Reply-To: <877bj2gs11.fsf@bootlin.com>
References:
 <ANsAVgA2LKxNoDvLnlQbwqow.1.1793115430251.Hmail.2301111981@stu.pku.edu.cn>
 <877bj2gs11.fsf@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa18c2c3f1c03a2kunm981d871b37286
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQkpDVk0eSB5DQkpPGRhKGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVITFVKQ1VCSFlXWRYaDxIVHRRZQVlPS0hVSktJQkNDTF
	VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=bmghQLpg5V/UoxF5bTCEZ9cMKTymtUoRzMzlKa4Z+xMeSBrLp7CL2LnqM6vKsU8IqRsvW20VHHD2pEoMKMmAc1KUkYkUmQyLHVPVfAJ0TbBHL5H0gTh7ONS8+WhsSnzyfwD2a2x1q5inumuGwbKi9+7ACR3Q0pTFQEoOwmvbnho=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=+y5ZcTSYD9voa3trTxpiYMMRe0qIdmly2cME/iyq9dQ=;
	h=date:mime-version:subject:message-id:from;

Hi Miquèl,

Sure. I have prepared and tested a fix. It makes
mac802154_transmit_beacon() use the wpan_dev already selected and pinned
by mac802154_beacon_worker(), instead of looking up local->beacon_req
again.

I have sent it as:

[PATCH net] mac802154: use pinned interface for beacon transmission

Thanks,
Yifan
