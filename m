Received: from mail-pj2-f17.google.com (mail-pj2-f17.google.com [74.125.227.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06343CE6A
	for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976529; cv=none; b=uc5E9guiuDOwHWozCYF0z9PRxLsEJq41dIU0NEEB+xILUPteXqj8+LE3OmlQV9uMUE/LsiKz3cisTw/yuOnKWCpzNAPx4awQlISMtSFhaTwo+pNWo0aYVDhkcuJ4JDOd9FBiU89zy5gSHF1M/VaBdH4m7kIF7Im8KBcao4n8IRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976529; c=relaxed/simple;
	bh=YsalEVAYHaGbe1Dk1lXHVV/f9d6wzLYXlYSBHBUtllk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLkbqdMRqjPy1k7WrFemveyxaW2r7xvxbi+1tzlR6BNT/RJ1iBjA2iGfra8PMAuFblvbEDTB1g8g3u0qAeW6tK6zp3rOV45wLIsjTZbujbuRlWKkwp2lhkl5ewK8H4P9V2/AfQY/SvcRA3iZDMVOII0kyZNyNXi2bI/rTbc6JkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9Tnx033; arc=none smtp.client-ip=74.125.227.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Tnx033"
Received: by mail-pj2-f17.google.com with SMTP id d9443c01a7336-2db1ca06a25so17478395ad.2
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976527; x=1790581327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGVEYz9jNs9cZq7gLpR3QmqEUgHVWJ7e7Dw6gUYLlpw=;
        b=A9Tnx0332d/SEN2nWTvHGWc9IHiBvg9mv1xWG4i6dlGY01iqpyluSwmOgX6j6H6rzA
         CqYrAF3hQCTprK1qnNnqgyQ1XJcWtajWxcPztZzrcjVC68XDuSqrii58HJWA2QfqCHBI
         rSTytd7Tr+fAbW/yvv0EQx3tdUONpoyiOKP/jPS2udPVmNVsSJ7uf+lYuwnwwnttJRiX
         ppPm9X6qTr6O/BlREFDQmRSqna24fB5IsqHhr/z1sWeuqyXxrhpsRqCCkOG88MbzGd40
         IfMuiHgKM/MzMu/JOVr5H6GaN9Yd4v0pbx3NkIS7ttmG+KGq3I8Eyj+fg/ah1gG8jLdY
         4ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976527; x=1790581327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pGVEYz9jNs9cZq7gLpR3QmqEUgHVWJ7e7Dw6gUYLlpw=;
        b=2Mks2ZC8rhHOLz67icw45oL0fbw2G73WDevxBT1yDecXVlRA06kZ3jZdmL9hF/ZxBX
         I/yd/gW3VsBxM+CW5TLrdxg3iEpNGcAo+ESm6rtCdHJgsKUHmXc9fhMnnXnbuBUKorw/
         pLVRP9JUxoRgYwSpWXzSxvWVn9i4CJQLqTM4CTHyMxkLY3uytmG8qXHrKarWX1HmD0zi
         l9jT/5gs2WNH2OY/KDf+CPVWcNBnLQN1xGbXIc5gTNP9jsBOODprvnuQmK5zprrh/Bgl
         +ZdnHdmybW+BnvO089ycpf2JBXsFCH8/gbL8BRlS3VhQPw55zX6AS8yLSfhdR6h3jk1C
         fKgA==
X-Gm-Message-State: AFuF++kA7zgErPuK28YfBc3sEF7GR7rySC6S/O0H06SzXu/Y2hdZUS9i
	uD+vM4jR+CfDSO232psQuexVMqACSkPu3XIkwxJoL0zYfGr13ubxcXuV+aUa1wqP
X-Gm-Gg: AYBFou17fUZbWW1WGXqGdf87hX5SfZ66A39yLVUCnpa79KIzYZvrFniMp/30o+Jgc7a
	cZ4DSawGR6Kr2RDyiLalplsceBRT48/CtG1tH8oVTPFDDaMbnrSmBVtWzPi4wp4l59+7TbB0rSk
	tEDkAbmLTxUslt6JKvW0rj3Yksu+Spn0uLt7ldczTidm/oAAXhDPcs/pPEP4DZcL8kN9yw6zxEf
	SXE3faPT459BljLf4OD6R2l89us8fGBQUH4VRRXvCnsfwv/1TNBO55gKzCQ72Uot1DLulqYKkYy
	rpc9JXE9br1pL8HonRNKX5KKUF9TpPGo21zdrSrUCgQodoVeGcarE3xsYNMshzSjQHFAMOX89M1
	nQrtEzp6btUpPlfAo3e+1CrWHh+tg0jXp8b4Z+VkBdZMhEcqvNxTrmwRwVZDu+qrHvkfbU7RBjy
	i1HQrnDMJBdcWZl+MggrRztg759lfkzEYYVHXe+iIdYUQBh1KlrAQJLDmaeE0vCYFBiChau8Li8
	L4FxxVUopb87tSqSac3VoEWWShggsY5nn7e6X3gEyTdihIIqrAhEfemjJSd+LQjmpDjUHlGsuV4
	m9fTRV6AvA==
X-Received: by 2002:a17:90a:d00e:b0:39d:fd82:de0c with SMTP id 98e67ed59e1d1-39e54aeed0emr14253187a91.2.1789976526598;
        Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabb771sm13015876a91.9.2026.09.21.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/3] ieee802154: ca8210: prevent stack buffer overflow in hwme_get_request_sync()
Date: Mon, 21 Sep 2026 07:42:04 +0000
Message-ID: <20260921074205.2289211-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213637.3316595-1-benquike@gmail.com>
References: <20260919213637.3316595-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
bytes into hw_attribute_value without checking the caller's destination
buffer capacity, overflowing level on the stack when hw_attribute_length
exceeds 1:

  BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
  Write of size 16 at addr ffff888001907780 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x3c/0x60
   hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
   ca8210_get_ed+0x9c/0xf0
  ...
  The buggy address belongs to stack of task init/1
   and is located at offset 48 in frame:
   ca8210_get_ed+0x0/0xf0
  This frame has 2 objects:
   [48, 49) 'level'
   [64, 65) 'lenvar'

Initialize lenvar = 1 in ca8210_get_ed() and return
IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
response.pdata.hwme_get_cnf.hw_attribute_length exceeds
*hw_attribute_length.

Tested in QEMU with KASAN enabled by passing an oversized
hw_attribute_length response into ca8210_get_ed().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 2/3.
- Replaced the temporary stack buffer in ca8210_get_ed() with lenvar = 1
  and an upper-bound check against *hw_attribute_length in
  hwme_get_request_sync() as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index c009930..1de6314 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1678,6 +1678,9 @@ static u8 hwme_get_request_sync(
 		return IEEE802154_SYSTEM_ERROR;
 
 	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
+		if (response.pdata.hwme_get_cnf.hw_attribute_length >
+		    *hw_attribute_length)
+			return IEEE802154_SYSTEM_ERROR;
 		*hw_attribute_length =
 			response.pdata.hwme_get_cnf.hw_attribute_length;
 		memcpy(
@@ -2028,7 +2031,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
  */
 static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	u8 lenvar;
+	u8 lenvar = 1;
 	struct ca8210_priv *priv = hw->priv;
 
 	return link_to_linux_err(
-- 
2.47.3
