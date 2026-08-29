Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC11D5146;
	Sat, 29 Aug 2026 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044587; cv=none; b=cZFYSwF1N6drSb6zcs7bXbgaQ/P/K4X7HZ74edDpH18h/Ef7Bg0N4yG02Ddaja6RFgAifcHX2ShRFqwa9B/hExpKwXgPYjPQIKNjIJWW+4XVVSQcCK1eJCuL3bXRqh5tTUtk7yeMomeY7X2s0p96G2MH//fp/UXoOTrVEqVnAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044587; c=relaxed/simple;
	bh=c39o0ERndxvmvuFitpw15CgstT8hPBsgQAkrVn8bMkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2DyTVS3j37n5IDNKVfxauaTxj7mWu52Y1Acp62c4FCN15SLOnHMDtHh6c4+oOP6QMO1XD+XSnP1HBG/6FKrIAg+Xh/yQoD0IJE8ee6NxDsYxQt/9wziefzGrfwJq/PAMbVLpcNVQbLNcUvT+KP6t33wQqRaZ0AmQruyOCD1v+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=Zt5mBzm6; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Zt5mBzm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=c39o0ERndxvmvuFitpw15CgstT8hPBsgQA
	krVn8bMkA=; b=Zt5mBzm60PJ08v/sG/MB5ifkSqUT9ciMzRUYSecZm9qpl4/EA6
	Ngvjelu3HwhxjOHPaKsm1pRnYsl64rhPUET+7RYCDxekLzgxNcOTvNpwZskpUcvq
	D5E2jUxVJ35EYh2skuD2+WZA1bkZVm2SUWtWyOUz/sExQi8cLiTBmKxBw=
Received: from skw.ustc.edu.cn (unknown [211.86.152.107])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCnpCsGZZNqHoG3AA--.2628S2;
	Sun, 30 Aug 2026 07:02:43 +0800 (CST)
From: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Subject: Re: [PATCH net v3] mac802154: fix data race and NULL deref on local->assoc_dev
Date: Sun, 30 Aug 2026 07:02:28 +0800
Message-Id: <20260829230228.1786426-1-skwkevin@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7a6ba0f3-efc0-45f1-a372-ced250733b62@linux.dev>
References: <20260827221339.885245-1-skwkevin@mail.ustc.edu.cn> <7a6ba0f3-efc0-45f1-a372-ced250733b62@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCnpCsGZZNqHoG3AA--.2628S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur43ZF4rKry7Xw43XryftFb_yoW8Cw18pr
	Z0qrn8Kw4kKwnIyrs2yr4FyFy3Zr1Sk3y3Xr1YgrW5u3Z8ZF18ZrW0qw1qyFWjyrs5Aa4F
	qF45WFZ7A3s8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_uwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUVwZcUUUUU=
X-CM-SenderInfo: 5vnzyvxylqqzxdloh3xvwfhvlgxou0/

Hi Xuanqiang,

> I think this clear_bit() should be moved to
> mac802154_process_association_resp(), after saving the first valid
> response and before calling complete().
>
> Clearing it only after wait_for_completion() returns may still leave a
> window, since the woken waiter may not acquire assoc_lock before the
> next work item runs. Clearing it earlier in the response handler ensures
> that subsequent responses fail the in-lock
> IEEE802154_IS_ASSOCIATING check and cannot overwrite the saved result.

Good catch, you are right. complete() is issued while the handler still
holds assoc_lock, so between the wake-up and the waiter taking that lock
another response can get in, pass the recheck and replace
assoc_status/assoc_addr before perform_association() has consumed them.

I reproduced it on a debug kernel: on v3 the bit is still set when the
wait returns, later responses keep being accepted after that point, and
the association ends up with an address from one of them instead of the
first one. With the clear_bit() moved, none is accepted.

So v4 does what you suggested: clear_bit() right after the result is
stored and before complete(), both under assoc_lock. The timeout and error
paths still clear it under the lock. The success and negative paths do not
need to any more, because a wait that returns success now means the
handler has already cleared the bit.

One thing I got wrong earlier, while I am at it. In my v2 reply I said
wpan_dev->association_lock is not held on either of the two paths
involved. That was wrong. nl802154_associate() takes it around
rdev_associate(), so it is held for the whole of
mac802154_perform_association(), the wait for the response included. That
rules out reusing it here: the handler would only get that mutex once the
association has already timed out. The v4 commit message states this
correctly.

A v4 follows.

Thanks,
Kaiwen

