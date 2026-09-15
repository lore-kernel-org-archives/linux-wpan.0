Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com [74.125.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B403D6477
	for <linux-wpan@vger.kernel.org>; Tue, 15 Sep 2026 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448501; cv=none; b=YybbWOXSHp5xaRDoLxqjMi9ZLrizvjeNEw9iwrqKGSieOJOLdyajo8ckBtdqq1KnGbkXskpGu3phjk0OhA8GSiq8VMAOaQTKaTSTKYfust8MbxZBu7GG01IMd4mGBYww39r+yLmWvVvuuQ4WBu5qF3bCntkVSH0khGhtN/JxgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448501; c=relaxed/simple;
	bh=x1gejsAd6YWA5CBEc/ub3FzHb3dF1/qcv14ggelBuvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnDy9ptHa6B5kDPowIs2j010Qt9PvpH/Iqhyi7bN6LnHIXqbMWlhRJKxJh+1nVmGN+LmznqwdxQdULIa0RdPts1OSe7vLU05p7FmaFrp/l0Uv9eJmggAsLB0YVXAKTq0RF16vInEksBz+vBHItkT0aNa5IcbucO5vlyhA8OnrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODXyVOZX; arc=none smtp.client-ip=74.125.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODXyVOZX"
Received: by mail-pz2-f25.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso2496542a12.2
        for <linux-wpan@vger.kernel.org>; Mon, 14 Sep 2026 22:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789448497; x=1790053297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qAZ/bCmEsYsB0LV/q1vRmEmrcb+izaYrj4LP1qy1vmw=;
        b=ODXyVOZX476O2LF2w9Y8f1RHyQIfPgCsAjNgWF600jwQS8GzP27wWYHOp7oddrhJOM
         ywfjjB9olLkBAUGluR3cB5GOSGoH/vh9jzwlEIyeagt9Rfh2xWslkaUulfHKVzDpP3nd
         NmsM56w07BucFsKak3j+v7W7VGkdtrVnnIrtjS/gWaQiHf/2dDKwwaxBmF7tL6W+oW6u
         gWFgKDycU+Fm7JHGyYk3Q4UNhIwO0MutwTeICSgQuQ9ekEfHi4S5NVna8Say4RqkX+/Y
         RWpslQRnc9CHAO/krmXw2+aMY69iLB/ZHNzrwFnCW+8WRlnbVfSAam+aCrtMet/fJexV
         gdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789448497; x=1790053297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qAZ/bCmEsYsB0LV/q1vRmEmrcb+izaYrj4LP1qy1vmw=;
        b=zseBOxyeLCJzAzV6Yg6Y2JvFUQoBHv7jjbKFSz8QrjFH3PDv2biBhtfpi+ILC5uSWU
         Jwqnt4iI/8K7WWBSbNTm3H+Um0EvY5gWXUEj8oxTAtj/yS7sv8m5mAKDtuS4QXIS0h15
         9zLmUFnMDUXU537MGBzGHHW30lY1JeRV7bcnnheLUDLJitVRum1u+0i0VFPSOTyO7nEU
         aKd+xG5Dj26KYqvO9AVv0TCiNJGRMESbXi2BhtU0kkT+qeH7he+gHLgBK50/OAIwTCcl
         gBI+GswvoQkKYugVefbmAPlbK50pcvX+C1TdTi+6TkBHtJMVlbAA+f8uS7uKGLLqrc1K
         r8CQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIYC/9/LtOC8TvwUqahkaKkf6mbvNB5nza1rszdQWus9z1mMFLrtx9rvLBbunw9DP+xjQAiNrpQvzK@vger.kernel.org
X-Gm-Message-State: AFuF++mnMtbdxR8FuQvYfONnz92EYdZN0KWZgVNdxv8wm38ya87DM8Q8
	5lzLHTBCRSdrOj6Hjrntx1JSSKopNZQF17rnGQVKBJ58MWBe68WrcvR6
X-Gm-Gg: AYBFou0d8oGekeNPs6nTyy20eNKVBzJE/5hoZgd02lZUaEQt3Ka66a1TtSYkkjmzyVn
	wuGdbsxG54RI8mBFV1RnhY8kAzRsi/kXUJmqEMu1aNtpX551EsjvVSInlQSxwnJWMyMhGy8N27S
	oNRAF42a+TXFK4Et+209AWr/vsQHEAIRP5evSJrjJro5gHy5ZggbYwZqZ1DR4EOAu91spev0EJo
	8WTt7SBwyJajgdWsZNYr5o6ur5BHAAMIz2z5Pi+nGPtbIo94FWgje8XYOeseLaD6ss5FUL1vxty
	NXmeb9Zg1+coc6U+enyxgGFJWbO7BHBjSwuJtSCR23tH1+3dQB4vFdcJyXiXL638rxwVf7AwqUo
	YFH3PxVanRsTSKQcoflxA5wecNiVBX7K6e/2aN4GSfGP6EdzhFCnlnffkgRYWSoEtrfx3bPpIxu
	dcuVCgNG6X5KO6kTSPE3BexLzpQAl4rpZe2lSUnsS7R6x/Z6+LgbQujBoEZ9ijXxGedQM/qyoM2
	lG3/pFP12vXndrNLkQjCieQdnHXbJhx40qlbfXQBFqypTv9mT3KfzbCK2Oeweejnwe/V8HLOtVB
	iR8zoDRnJoxWKQBmvZby
X-Received: by 2002:a17:90b:4a0f:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39debf7613bmr9948084a91.6.1789448496872;
        Mon, 14 Sep 2026 22:01:36 -0700 (PDT)
Received: from lawlee-vm0.d4y3nv5wwgfelhhopdxv1tqjld.dx.internal.cloudapp.net ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e51449sm26872358eec.5.2026.09.14.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:01:36 -0700 (PDT)
From: Lawrence Lee <lfqlee314@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	Arun Ajith S <aajith@arista.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH net-next v2 1/2] ipv6: update NUD_FAILED neighbors from NA messages
Date: Tue, 15 Sep 2026 05:01:31 +0000
Message-ID: <6596966f734f3d416bfa83722f7a595149bcc3f8.1789448374.git.lfqlee314@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789448374.git.lfqlee314@gmail.com>
References: <cover.1789448374.git.lfqlee314@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Transition a FAILED neighbor entry to STALE upon receipt of an NA
message on routers when accept_untracked_na is enabled. This extends the
RFC 9131 accept_untracked_na behavior so that FAILED entries are treated
the same as non-existent entries. In the context of RFC 4861 which
introduced NDP, both non-existent and FAILED entries are considered
untracked since they do not have a valid neighbor cache entry.

Trying to resolve FAILED neighbors via periodic probing (e.g. using
NTF_EXT_MANAGED) is more work compared to this approach which uses
information in NAs that the kernel may already be receiving. Note that
because this behavior in IPv6 is dependent on the accept_untracked_na
sysctl setting, this approach is more conservative than IPv4 which
transitions FAILED neighbors to STALE by default upon receiving GARPs.

Link: https://lore.kernel.org/r/20260813233344.445265-1-lfqlee314@gmail.com
Assisted-by: LLM Sashiko sparse
Signed-off-by: Lawrence Lee <lfqlee314@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 28 ++++----
 include/net/ndisc.h                    | 15 ++--
 net/6lowpan/ndisc.c                    | 15 ++--
 net/ipv6/ndisc.c                       | 94 +++++++++++++++++---------
 4 files changed, 96 insertions(+), 56 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 208f46967ee5..4cc57a6be99b 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -3223,18 +3223,19 @@ drop_unsolicited_na - BOOLEAN
 	Default: 0 (disabled).
 
 accept_untracked_na - INTEGER
-	Define behavior for accepting neighbor advertisements from devices that
-	are absent in the neighbor cache:
+	Define behavior for accepting neighbor advertisements for IPv6 addresses
+	that are absent from the neighbor cache or whose entries are in FAILED
+	state:
 
-	- 0 - (default) Do not accept unsolicited and untracked neighbor
-	  advertisements.
+	- 0 - (default) Do not create new neighbor cache entries or update
+	  FAILED entries from neighbor advertisements.
 
-	- 1 - Add a new neighbor cache entry in STALE state for routers on
-	  receiving a neighbor advertisement (either solicited or unsolicited)
-	  with target link-layer address option specified if no neighbor entry
-	  is already present for the advertised IPv6 address. Without this knob,
-	  NAs received for untracked addresses (absent in neighbor cache) are
-	  silently ignored.
+	- 1 - For routers, add a new neighbor cache entry or update an existing
+	  FAILED entry to STALE upon receiving a neighbor advertisement (either
+	  solicited or unsolicited) with the target link-layer address option
+	  specified. Without this knob, NAs received for untracked addresses
+	  (absent from the neighbor cache or in FAILED state) are silently
+	  ignored.
 
 	  This is as per router-side behavior documented in RFC9131.
 
@@ -3249,9 +3250,10 @@ accept_untracked_na - INTEGER
 	  used in conjunction with the ndisc_notify setting on the host to
 	  satisfy this prerequisite.
 
-	- 2 - Extend option (1) to add a new neighbor cache entry only if the
-	  source IP address is in the same subnet as an address configured on
-	  the interface that received the neighbor advertisement.
+	- 2 - Extend option (1) to add a new neighbor cache entry or update a
+	  FAILED entry only if the source IP address is in the same subnet as
+	  an address configured on the interface that received the neighbor
+	  advertisement.
 
 enhanced_dad - BOOLEAN
 	Include a nonce option in the IPv6 neighbor solicitation messages used for
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 96e3bb6e83af..7fb3f10eca6c 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -154,11 +154,13 @@ void __ndisc_fill_addr_option(struct sk_buff *skb, int type, const void *data,
  *     option parser will take care about that option.
  *
  * void (*update)(const struct net_device *dev, struct neighbour *n,
- *		  u32 flags, u8 icmp6_type,
+ *		  u32 flags, bool failed_recovery, u8 icmp6_type,
  *		  const struct ndisc_options *ndopts):
  *     This function is called when IPv6 ndisc updates the neighbour cache
  *     entry. Additional options which can be updated may be previously
  *     parsed by parse_opts callback and accessible over ndopts parameter.
+ *     failed_recovery indicates that ndisc accepted the packet to recover
+ *     an entry observed in NUD_FAILED.
  *
  * int (*opt_addr_space)(const struct net_device *dev, u8 icmp6_type,
  *			 struct neighbour *neigh, u8 *ha_buf,
@@ -197,7 +199,7 @@ struct ndisc_ops {
 				 struct nd_opt_hdr *nd_opt,
 				 struct ndisc_options *ndopts);
 	void	(*update)(const struct net_device *dev, struct neighbour *n,
-			  u32 flags, u8 icmp6_type,
+			  u32 flags, bool failed_recovery, u8 icmp6_type,
 			  const struct ndisc_options *ndopts);
 	int	(*opt_addr_space)(const struct net_device *dev, u8 icmp6_type,
 				  struct neighbour *neigh, u8 *ha_buf,
@@ -227,12 +229,13 @@ static inline int ndisc_ops_parse_options(const struct net_device *dev,
 }
 
 static inline void ndisc_ops_update(const struct net_device *dev,
-					  struct neighbour *n, u32 flags,
-					  u8 icmp6_type,
-					  const struct ndisc_options *ndopts)
+				    struct neighbour *n, u32 flags,
+				    bool failed_recovery, u8 icmp6_type,
+				    const struct ndisc_options *ndopts)
 {
 	if (dev->ndisc_ops && dev->ndisc_ops->update)
-		dev->ndisc_ops->update(dev, n, flags, icmp6_type, ndopts);
+		dev->ndisc_ops->update(dev, n, flags, failed_recovery,
+				       icmp6_type, ndopts);
 }
 
 static inline int ndisc_ops_opt_addr_space(const struct net_device *dev,
diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
index 868d28583c0a..8fedfef93740 100644
--- a/net/6lowpan/ndisc.c
+++ b/net/6lowpan/ndisc.c
@@ -47,7 +47,8 @@ static int lowpan_ndisc_parse_options(const struct net_device *dev,
 	}
 }
 
-static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
+static void lowpan_ndisc_802154_update(struct neighbour *n,
+				       bool failed_recovery,
 				       u8 icmp6_type,
 				       const struct ndisc_options *ndopts)
 {
@@ -87,20 +88,24 @@ static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
 		ieee802154_be16_to_le16(&neigh->short_addr, lladdr_short);
 		if (!lowpan_802154_is_valid_src_short_addr(neigh->short_addr))
 			neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+	} else if (failed_recovery) {
+		neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
 	}
 	write_unlock_bh(&n->lock);
 }
 
 static void lowpan_ndisc_update(const struct net_device *dev,
-				struct neighbour *n, u32 flags, u8 icmp6_type,
+				struct neighbour *n, u32 flags,
+				bool failed_recovery, u8 icmp6_type,
 				const struct ndisc_options *ndopts)
 {
 	if (!lowpan_is_ll(dev, LOWPAN_LLTYPE_IEEE802154))
 		return;
 
-	/* react on overrides only. TODO check if this is really right. */
-	if (flags & NEIGH_UPDATE_F_OVERRIDE)
-		lowpan_ndisc_802154_update(n, flags, icmp6_type, ndopts);
+	/* React to overrides or accepted FAILED-entry recovery. */
+	if ((flags & NEIGH_UPDATE_F_OVERRIDE) || failed_recovery)
+		lowpan_ndisc_802154_update(n, failed_recovery, icmp6_type,
+					   ndopts);
 }
 
 static int lowpan_ndisc_opt_addr_space(const struct net_device *dev,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 90cd5d852569..84d70c09205a 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -778,13 +778,23 @@ static int pndisc_is_router(const void *pkey,
 	return ret;
 }
 
+static void __ndisc_update(const struct net_device *dev,
+			   struct neighbour *neigh, const u8 *lladdr, u8 new,
+			   u32 flags, bool failed_recovery, u8 icmp6_type,
+			   struct ndisc_options *ndopts)
+{
+	neigh_update(neigh, lladdr, new, flags, 0);
+	/* report ndisc ops about neighbour update */
+	ndisc_ops_update(dev, neigh, flags, failed_recovery, icmp6_type,
+			 ndopts);
+}
+
 void ndisc_update(const struct net_device *dev, struct neighbour *neigh,
 		  const u8 *lladdr, u8 new, u32 flags, u8 icmp6_type,
 		  struct ndisc_options *ndopts)
 {
-	neigh_update(neigh, lladdr, new, flags, 0);
-	/* report ndisc ops about neighbour update */
-	ndisc_ops_update(dev, neigh, flags, icmp6_type, ndopts);
+	__ndisc_update(dev, neigh, lladdr, new, flags, false, icmp6_type,
+		       ndopts);
 }
 
 static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
@@ -972,14 +982,18 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 
 static int accept_untracked_na(struct inet6_dev *idev, struct in6_addr *saddr)
 {
+    /* For any given neighbor IP address, consider it an untracked neighbor if
+     * it is absent from the neighbor cache or if it has a NUD_FAILED entry in
+     * the neighbor cache
+     */
 	switch (READ_ONCE(idev->cnf.accept_untracked_na)) {
-	case 0: /* Don't accept untracked na (absent in neighbor cache) */
+	case 0: /* Reject NAs for untracked neighbours */
 		return 0;
-	case 1: /* Create new entries from na if currently untracked */
+	case 1: /* Accept NAs for untracked neighbours */
 		return 1;
-	case 2: /* Create new entries from untracked na only if saddr is in the
+	case 2: /* Accept NAs for untracked neighbours only if saddr is in the
 		 * same subnet as an address configured on the interface that
-		 * received the na
+		 * received the NA
 		 */
 		return !!ipv6_chk_prefix(saddr, idev->dev);
 	default:
@@ -1001,6 +1015,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	struct neigh_table *tbl;
 	struct neighbour *neigh;
 	struct inet6_dev *idev;
+	bool neigh_failed = false;
+	bool neigh_untracked = false;
+	bool accept_untracked = false;
 	u8 *lladdr = NULL;
 	SKB_DR(reason);
 	u8 new_state;
@@ -1067,32 +1084,41 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	neigh = neigh_lookup(tbl, &msg->target, dev);
 
 	/* RFC 9131 updates original Neighbour Discovery RFC 4861.
-	 * NAs with Target LL Address option without a corresponding
-	 * entry in the neighbour cache can now create a STALE neighbour
-	 * cache entry on routers.
+	 * NAs with Target LL Address option can now create a STALE neighbor
+	 * cache entry on routers if the NA does not have a corresponding entry
+	 * in the neighbour cache or has a corresponding FAILED entry.
 	 *
-	 *   entry accept  fwding  solicited        behaviour
-	 * ------- ------  ------  ---------    ----------------------
-	 * present      X       X         0     Set state to STALE
-	 * present      X       X         1     Set state to REACHABLE
-	 *  absent      0       X         X     Do nothing
-	 *  absent      1       0         X     Do nothing
-	 *  absent      1       1         X     Add a new STALE entry
+	 *       entry accept  fwding  solicited        behaviour
+	 * ----------- ------  ------  ---------    ----------------------
+	 *  non-FAILED      X       X         0     Set state to STALE
+	 *  non-FAILED      X       X         1     Set state to REACHABLE
+	 *      FAILED      0       X         X     Do nothing
+	 *      FAILED      1       0         X     Do nothing
+	 *      FAILED      1       1         X     Set state to STALE
+	 *      absent      0       X         X     Do nothing
+	 *      absent      1       0         X     Do nothing
+	 *      absent      1       1         X     Add a new STALE entry
 	 *
 	 * Note that we don't do a (daddr == all-routers-mcast) check.
 	 */
 	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
-	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
-		if (accept_untracked_na(idev, saddr)) {
-			neigh = neigh_create(tbl, &msg->target, dev);
-			new_state = NUD_STALE;
-		}
-	}
+	neigh_failed = neigh &&
+		       (READ_ONCE(neigh->nud_state) & NUD_FAILED);
+	neigh_untracked = !neigh || neigh_failed;
+	if (neigh_untracked) {
+		accept_untracked = lladdr && idev &&
+				   READ_ONCE(idev->cnf.forwarding) &&
+				   accept_untracked_na(idev, saddr);
+		new_state = NUD_STALE;
+	}
+	if (!neigh && accept_untracked)
+		neigh = neigh_create(tbl, &msg->target, dev);
 
 	if (neigh && !IS_ERR(neigh)) {
+		u32 update_flags;
 		u8 old_flags = neigh->flags;
 
-		if (READ_ONCE(neigh->nud_state) & NUD_FAILED)
+		if (neigh_untracked && !accept_untracked)
 			goto out;
 
 		/*
@@ -1108,19 +1134,23 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 			goto out;
 		}
 
-		ndisc_update(dev, neigh, lladdr,
-			     new_state,
-			     NEIGH_UPDATE_F_WEAK_OVERRIDE|
-			     (msg->icmph.icmp6_override ? NEIGH_UPDATE_F_OVERRIDE : 0)|
-			     NEIGH_UPDATE_F_OVERRIDE_ISROUTER|
-			     (msg->icmph.icmp6_router ? NEIGH_UPDATE_F_ISROUTER : 0),
-			     NDISC_NEIGHBOUR_ADVERTISEMENT, &ndopts);
+		update_flags = NEIGH_UPDATE_F_WEAK_OVERRIDE |
+			       (msg->icmph.icmp6_override ?
+				NEIGH_UPDATE_F_OVERRIDE : 0) |
+			       NEIGH_UPDATE_F_OVERRIDE_ISROUTER |
+			       (msg->icmph.icmp6_router ?
+				NEIGH_UPDATE_F_ISROUTER : 0);
+
+		__ndisc_update(dev, neigh, lladdr,
+			       new_state, update_flags, neigh_failed,
+			       NDISC_NEIGHBOUR_ADVERTISEMENT, &ndopts);
 
 		if ((old_flags & ~neigh->flags) & NTF_ROUTER) {
 			/*
 			 * Change: router to host
 			 */
-			rt6_clean_tohost(dev_net(dev),  saddr);
+			rt6_clean_tohost(net,
+					 neigh_failed ? &msg->target : saddr);
 		}
 		reason = SKB_CONSUMED;
 out:
-- 
2.43.0
