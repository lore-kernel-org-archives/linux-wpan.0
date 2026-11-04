Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758507;
	b=dhohNaWzppahNCCXrww3nCyMJxrYgOagaA/r7c90G4J9yDmXZX4Z6m4gl0Ojf6XU7SUw
	 R3IvjHPHgdKAUD+dGbhphzFk+cIEFG1WFGBP3Th9su0diXeQX4u+bPCPxHw1o+Yf164AN
	 ivF5gJfFA4jQqOmIepu+fOGfhSbIgzhRxAzqasp1A12v7sGgTZTdw+6Ee+OWpsoAyQT+d
	 fwq2fmT5o1V500k0K1KmHJyTU5hAu0SmXZ7s97ZJ7XXe5YzH0CWft9reYHOeL62HK6q5l
	 2alIcCJahh4RrnvO9qtJkqXeFqtAfk+CY9AnvZOBMV/djfvQjsnnPG+BJNKdsCjznMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758507;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=KCVoTIbXy96jCroV4C2G1A6meDs0e6KbH5onKp8a1a4=;
	b=W4NO1XR9a81i3vXG07RNoKpw9krzYKqLnBHsbq7bDEhbONjtgjtxo9rQ+nX7pb5Qe9YE
	 VGnDcGMBLf38xyzhJa+HVZ4TQrxN13NXzNjqvXZaenorrnPMYkYC1i4iX7XX1feth+KHW
	 rhxb6ppZOKYbUGyxgx2nWm82suPY5QJP/O4AdeDHxkDxsNW9e3ELCmgvDb3gqTtfHxUX7
	 Eypq40VAGL2cLmTO2HhpKT4Xt1Zt2U3I7ZWOHYxE1P9z8mtSkXuR8c66XPdCWmF+atf++
	 Um9B6FZmA/qASJHWfpstVl4cN0a9XIaErTZR+DsO8LMhTTgMaYGgCU20DnzXXIss8mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F76606A333;
	Wed,  4 Nov 2026 02:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F76606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADXxf8ZlepqMHY+AA--.9580S2;
	Wed, 04 Nov 2026 10:14:49 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Stefan Schmidt <stefan@datenfreihafen.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] ieee802154: atusb: drop the URB reference after a failed resubmit
Date: Wed,  4 Nov 2026 02:14:58 +0000
Message-Id: <20261104021458.1468481-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXxf8ZlepqMHY+AA--.9580S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JryUKFWfKFW7Zw15Kw4UJwb_yoWkXFX_Kr
	ySvF93Xry5CFsFk3W5AFsxZrWvk3ZFqFs3ZFWagayfJ3yYyF1I9F40yas8Gw4UGrsIvF9x
	JwnxJr4Ut34SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAYjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIYiiDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgQBA2rqY4K7qwAAsx

usb_get_from_anchor() returns the URB with a reference held by the
caller.  When atusb_submit_rx_urb() fails, that reference is not consumed,
and re-anchoring the URB takes an additional one.  The caller's reference
is then never dropped.

Release it after putting the URB back on the idle anchor.

Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ieee802154/atusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 5f7fc4ee7a07..c924f17171f4 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -183,6 +183,7 @@ static void atusb_work_urbs(struct work_struct *work)
 	} while (!ret);
 
 	usb_anchor_urb(urb, &atusb->idle_urbs);
+	usb_free_urb(urb);
 	dev_warn_ratelimited(&usb_dev->dev,
 			     "atusb_in: can't allocate/submit URB (%d)\n", ret);
 	schedule_delayed_work(&atusb->work,
-- 
2.34.1

