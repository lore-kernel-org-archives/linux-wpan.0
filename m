Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759289;
	b=h95uyJzRfUdJiqJ+JqoBjEQX0eoNAYlMosXIDya1t6Z78S87wMD5CL/i8kptMgjHxhye
	 vWRU+bjv1jSnh0sK1a4e3gxJnxrlaqes2DRMYQcWBW4wjt/Q3BTiuGyfe4P8bXqwyekU2
	 mCZej84AG4HHsN/rDNJ414B6KJUQszgVpEckY2MGp1Qy5hzx3Gakm5qUR/3z5u2zjORM0
	 A/Tbf76eJ8YW6B2/nHz1vVlL6haYQ61Vnl6TTu5FdlWijngjkRlbQnrAPsplAnW1LqlKZ
	 BtxckoZaZYwqMN2zDZ5ZgT2szvoU5mcAtm3mRygQabny/kwSzeHN4gkUeX+7dLc3htg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759289;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=m3ICyWKLt/3CRgSG3lfoecO7ZJvBzNsttX/y1Vej1r4=;
	b=ZEJwt5cOPRlmLzTTxKdeQW02r9txKgnhcgn8NTtqEVLsO0W8ehsj78hu0Fo41tr5RGn1
	 3JPJihgnEXZnAr/2miz7IYv1ZsWoJFksnjaLTEJoGbfT3Ymo/65HtHGr7SGWLfQuEsor7
	 gF8/KzG/pLw0fnTcWKghj/MxGq8VPoI343a81S+loCvoP25f/o8jpGoieEH4hUmBEIeoR
	 5rypewwjrh7BxPXGdAAqeuijffe4XRliKujIhnofmmcdM4s2ulYnNnZEUDk0O+Wfx0LCq
	 kYY4+po8L5S5jtrAc41yXNmwMKOEeEsZZ9Ek4oxo3sYGVY7Mn/Pwmo3QfodxN9dXDRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAA606A31B;
	Wed,  4 Nov 2026 02:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7BAA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABHcPowmOpqmZs+AA--.42059S2;
	Wed, 04 Nov 2026 10:28:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] ieee802154: drop the extra phy reference in del_iface
Date: Wed,  4 Nov 2026 02:28:09 +0000
Message-Id: <20261104022809.1484165-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABHcPowmOpqmZs+AA--.42059S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XF48JrWftFy7Ww17Cr4kZwb_yoW8Jr4fpa
	y5u34UKr98Wr13W3yxA3WxGF1SkwsrtryruF1kAanYyr18Xa43C39agw4Ivr13Ar4kZFy5
	CFyUtF1rZ34DCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUyXo2DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUBA2rqY-nHUAAAsT

ieee802154_del_iface() takes a reference on the phy of the interface and
then looks up the phy named by IEEE802154_ATTR_PHY_NAME, which takes
another reference. When the optional attribute names the phy of the
interface being deleted, phy and phy2 are the same device, the lookup
reference is not dropped and the function later puts the phy only once.
Deleting an interface while passing its own phy name therefore leaks a
wpan_phy reference.

Put the lookup reference in the matching case as well, leaving only the
reference taken from the interface.

Fixes: bb1cafb8fc41 ("ieee802154: add support for creation/removal of logic interfaces")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/ieee802154/nl-phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 4c07a475c567..e7a8237b73c3 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -311,6 +311,8 @@ int ieee802154_del_iface(struct sk_buff *skb, struct genl_info *info)
 			wpan_phy_put(phy2);
 			goto out_dev;
 		}
+
+		wpan_phy_put(phy2);
 	}
 
 	rc = -ENOBUFS;
-- 
2.34.1

