Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC713B47EE;
	Wed, 27 May 2026 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913100; cv=none; b=bMxXBNPh8r8Xsx40b3TJoW0cqeX9fVol8V+1RZTujqq8CaUqNPOd8Yk0cCfoE16G7bALw4sEeqd1Zwmv9b3hXSVRxa2vTCM3gEKYwYKmu05eep7ssfaCBzXrhGsYcmDd6FQD8+LvVEyChIqpsvSSBSo4zhGCirRNZJwpHsazS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913100; c=relaxed/simple;
	bh=DNWK8fWvqEZ0UHlUCqs9f738tVYWPqYCOIF175utZ7o=;
	h=From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Date; b=EYiMqaQ1lW4wMgVNWVadRMvYoi3GdCz7mu42Z1gClXGY6bKsQBUY8aMT04vb/TU4ovYyRJXLOhyZzo9peCyfcltK8bUQhl8vv7kOzFAMfm+RQLRDdNMLSuDsmBFoHia22tL0p9WftVvquBIq6GhMjCOsP3M7+WheF05jZE535FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNFt3UpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNFt3UpC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8B63F1F00A3D;
	Wed, 27 May 2026 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779913099;
	bh=DYLUd3afQlwG7kekyWqFmew86E2EaHaXJzEC9U/N4kA=;
	h=From:To:Cc:Subject:Date;
	b=YNFt3UpCsb3yvvjUPevQafClycXtg1fUH8clXiVLfUhixPC6qpmX8bXvmVi7uittl
	 Ntu8S63lx6TVXn39jVDFKbFDShZkZUu6wNEWkbP8Zf41Ws9U0URIoCiuU2bjSxI8J0
	 FmnjsAsd9s+AdjojN4vZVl183WTS+YqSSUB52rD8HMlidCKRnafERy4Gs1Q3qKISv3
	 kcQANJy+DtNEcsa8mm0203Yy7t0iZ+TPAs0wi5mtxaKxEraziH5cmQLxI7sKvGXvrI
	 isTQfOS7zXE4TGCOoqcKvHFRG54sR7Bzx+JrykWdIKc5FpGGUBO2CLNZN3wi07ktH6
	 kIPb8C6IW2kYQ==
From: "syzbot" <syzbot@kernel.org>
To: syzkaller-bugs@googlegroups.com, "Alexander Aring" <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, <linux-wpan@vger.kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>, <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Stefan Schmidt" <stefan@datenfreihafen.org>
Cc: horms@kernel.org, linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
Subject: [PATCH] ieee802154: fix kernel-infoleak in dgram_recvmsg()
Message-ID: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Wed, 27 May 2026 20:18:18 +0000 (UTC)

From: Aleksandr Nogikh <nogikh@google.com>

KMSAN reported a kernel-infoleak in move_addr_to_user():

BUG: KMSAN: kernel-infoleak in instrument_copy_to_user
include/linux/instrumented.h:131 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user
include/linux/uaccess.h:205 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xcc/0x120
lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:131 [inline]
 _inline_copy_to_user include/linux/uaccess.h:205 [inline]
 _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:236 [inline]
 move_addr_to_user+0x2e7/0x440 net/socket.c:302
 ____sys_recvmsg+0x232/0x610 net/socket.c:2925
 ...
 Uninit was stored to memory at:
 ieee802154_addr_to_sa include/net/ieee802154_netdev.h:369 [inline]
 dgram_recvmsg+0xa09/0xbe0 net/ieee802154/socket.c:739

The issue occurs because the `pan_id` field of `struct ieee802154_addr`
is left uninitialized when the address mode is `IEEE802154_ADDR_NONE`.
The execution flow is as follows:

1. `__ieee802154_rx_handle_packet()` declares a local `struct
ieee802154_hdr hdr` on the stack.
2. `ieee802154_hdr_pull()` calls `ieee802154_hdr_get_addr()` to parse
the source and destination addresses into this structure.
3. If the address mode is `IEEE802154_ADDR_NONE`,
`ieee802154_hdr_get_addr()` previously only set the `mode` field,
leaving the `pan_id` field containing uninitialized stack memory.
4. This uninitialized `pan_id` is later copied into a `struct
sockaddr_ieee802154` in `dgram_recvmsg()` via `ieee802154_addr_to_sa()`.
5. Finally, `move_addr_to_user()` copies the socket address structure to
user space, leaking the uninitialized bytes.

Fix this by using `memset` to zero out the address structure in
`ieee802154_hdr_get_addr()` when the mode is `IEEE802154_ADDR_NONE`.

Fixes: 94b4f6c21cf5 ("ieee802154: add header structs with endiannes and operations")
Assisted-by: Gemini:gemini-3.1-pro-preview Gemini:gemini-3-flash-preview syzbot
Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
Link: https://syzkaller.appspot.com/ai_job?id=a507a109-d683-4a2c-bc03-93394f491b17
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>

---
diff --git a/net/ieee802154/header_ops.c b/net/ieee802154/header_ops.c
index 41a556be1..a9f0c8df5 100644
--- a/net/ieee802154/header_ops.c
+++ b/net/ieee802154/header_ops.c
@@ -173,10 +173,13 @@ ieee802154_hdr_get_addr(const u8 *buf, int mode, bool omit_pan,
 {
 	int pos = 0;
 
-	addr->mode = mode;
-
-	if (mode == IEEE802154_ADDR_NONE)
+	if (mode == IEEE802154_ADDR_NONE) {
+		memset(addr, 0, sizeof(*addr));
+		addr->mode = IEEE802154_ADDR_NONE;
 		return 0;
+	}
+
+	addr->mode = mode;
 
 	if (!omit_pan) {
 		memcpy(&addr->pan_id, buf + pos, 2);


base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
See https://github.com/google/syzkaller/blob/master/docs/syzbot_ai_patches.md for information about AI-generated patches.
You can comment on the patch as usual, syzbot will try to address
the comments and send a new version of the patch if necessary.
syzbot engineers can be reached at syzkaller@googlegroups.com.
