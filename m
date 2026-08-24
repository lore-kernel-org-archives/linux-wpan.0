Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37E37F320;
	Mon, 24 Aug 2026 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594458; cv=none; b=izim26JqJDJtwnEYJy3F3A9qYJBlfOrGlLFXkiEfJQndhCoG0TWH3HCZtofCMlBEY8pO477YJp/6tCZ+lS97svBiJ/zCWlOX6D+WqEIJWTKvKViv3Q4eQmIcVY/xCKZLh1U9UFSmcj8gLILlbU40qvWaQZQgAn0P7Deg2jGLyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594458; c=relaxed/simple;
	bh=TFnI2k74m5NXMhdD6k0V+J5zTUI3JbFerKb+sRWbnjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Id98a0JP9oRV2IivzgvgtO01ky2gyMVr5oJTegvLFQlEfb+jJOjsgENm5sSTL5bUEuS8NgSP5XMr19wjr/mK8gJxgSRYRzl/tn/3ovJ6DvNFVzEBEpV9GijdHxH23gd6S8K8sUO7sKIBP1IZ4qMiOoNNsn9w9cGU1fInRCsW41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=lXoZuc+a; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="lXoZuc+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=yPRFsNqO3M
	dRSvkCjq6iY4sm1WM52wHzvKYHEk5yraQ=; b=lXoZuc+apKYGggpfJ3w2+KDh1j
	0QqZAgqsJcRE1g/+OCioBcYJ0cZRdhWnzp3D/WChUSNElxkVg9i6CE2Z6DxWR/VF
	eXUqHUf3SHnEVX9PmchHViwxfKB6MMx3JHIEeq4qhlEYVN8v8MKfVjfY5ohToCeB
	cGZI2HjG5WIo3zzPY=
Received: from skw.ustc.edu.cn (unknown [211.86.152.107])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgA3OzKLhoxq3p6RAA--.3675S2;
	Tue, 25 Aug 2026 01:59:47 +0800 (CST)
From: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaiwen Shi <skwkevin@mail.ustc.edu.cn>
Subject: [PATCH net] mac802154: fix data race and NULL deref on local->assoc_dev
Date: Tue, 25 Aug 2026 01:59:38 +0800
Message-Id: <20260824175938.11143-1-skwkevin@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgA3OzKLhoxq3p6RAA--.3675S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AryxZw1rWr1fur17uw1DAwb_yoW7Gw4xpF
	yj9Fn5KFy7JrnxZwn3J3Z5Xry29r48Cw1xur1fAFZxZF1kWF98ZF4aqrnFvFyYqF4kZa4r
	ZrWDJa15AF1DC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCY02Avz4vE14v_GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUjj2NtUUUUU==
X-CM-SenderInfo: 5vnzyvxylqqzxdloh3xvwfhvlgxou0/

`local->assoc_dev` is accessed from three places with no common lock
and, on the read side, no NULL or lifetime guarantee:

  - mac802154_perform_association() stores the coordinator pointer in
    it, then blocks in wait_for_completion_killable_timeout() for up
    to 10 s;

  - its clear_assoc label sets it back to NULL;

  - mac802154_process_association_resp(), which runs from the
    rx_mac_cmd workqueue, dereferences
    `local->assoc_dev->extended_addr` with neither lock nor NULL
    check.

The dereference races with both write sites:

  1. NULL dereference: clear_assoc() stores NULL while the RESP
     handler is between loading and dereferencing the pointer; the
     subsequent dereference of `->extended_addr` on a NULL pointer
     faults.

  2. use-after-free: mac802154_associate() frees the freshly
     allocated `parent` in its free_parent path after
     perform_association() returns an error. If the RESP handler
     still holds the now-dangling pointer, it reads freed memory.

No existing lock serializes these accesses.  The
wpan_dev->association_lock mutex only guards the coordinator-side
parent/child list (mac802154_process_association_req() and
friends), which is a different data structure, and it is not held
while this device is associating.  The writer blocks in
wait_for_completion_killable_timeout() for up to 10 s after storing
assoc_dev, so the reader on the rx_mac_cmd workqueue races with both
the NULL store in clear_assoc and the kfree() of the leftover
ieee802154_pan_device in mac802154_associate()'s error path.

Add a dedicated assoc_dev_lock and hold it around all three
accesses; the RESP handler additionally validates the pointer before
dereferencing it.  This is a per-field lock so it cannot contend
with the completion logic.

Fixes: fefd19807fe9 ("mac802154: Handle associating")
Signed-off-by: Kaiwen Shi <skwkevin@mail.ustc.edu.cn>

---
Best regards,
Kaiwen Shi

 net/mac802154/ieee802154_i.h |  1 +
 net/mac802154/main.c         |  1 +
 net/mac802154/scan.c         | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 8f2bff268392..921712ee2a37 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -77,6 +77,7 @@ struct ieee802154_local {
 
 	/* Association */
 	struct ieee802154_pan_device *assoc_dev;
+	spinlock_t assoc_dev_lock; /* protects assoc_dev */
 	struct completion assoc_done;
 	__le16 assoc_addr;
 	u8 assoc_status;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index ea1efef3572a..e59f46100203 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -104,6 +104,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	INIT_WORK(&local->rx_mac_cmd_work, mac802154_rx_mac_cmd_worker);
 
 	init_completion(&local->assoc_done);
+	spin_lock_init(&local->assoc_dev_lock);
 
 	/* init supported flags with 802.15.4 default ranges */
 	phy->supported.max_minbe = 8;
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 65089826ff59..5ef23a4507ea 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -574,7 +574,9 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 		return ret;
 	}
 
+	spin_lock_bh(&local->assoc_dev_lock);
 	local->assoc_dev = coord;
+	spin_unlock_bh(&local->assoc_dev_lock);
 	reinit_completion(&local->assoc_done);
 	set_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
 
@@ -613,7 +615,9 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 
 clear_assoc:
 	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
+	spin_lock_bh(&local->assoc_dev_lock);
 	local->assoc_dev = NULL;
+	spin_unlock_bh(&local->assoc_dev_lock);
 
 	return ret;
 }
@@ -626,6 +630,7 @@ int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
 	u64 deaddr = swab64((__force u64)dest->extended_addr);
 	struct ieee802154_local *local = sdata->local;
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	struct ieee802154_pan_device *assoc_dev;
 	struct ieee802154_assoc_resp_pl resp_pl = {};
 
 	if (skb->len != sizeof(resp_pl))
@@ -635,9 +640,15 @@ int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
 		     dest->mode != IEEE802154_EXTENDED_ADDRESSING))
 		return -EINVAL;
 
-	if (unlikely(dest->extended_addr != wpan_dev->extended_addr ||
-		     src->extended_addr != local->assoc_dev->extended_addr))
+	spin_lock_bh(&local->assoc_dev_lock);
+	assoc_dev = local->assoc_dev;
+	if (unlikely(!assoc_dev ||
+		     dest->extended_addr != wpan_dev->extended_addr ||
+		     src->extended_addr != assoc_dev->extended_addr)) {
+		spin_unlock_bh(&local->assoc_dev_lock);
 		return -ENODEV;
+	}
+	spin_unlock_bh(&local->assoc_dev_lock);
 
 	memcpy(&resp_pl, skb->data, sizeof(resp_pl));
 	local->assoc_addr = resp_pl.short_addr;
-- 
2.47.0

