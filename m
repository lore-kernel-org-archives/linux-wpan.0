Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC3357D0D
	for <linux-wpan@vger.kernel.org>; Thu, 10 Sep 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072280; cv=pass; b=AYB7WAyvZ9PGiLCqk7Y7e1bFO7CnteUCeaIfuwhOM1SV4+uOCkaYA8IY3gfoCu+ptIUGChsrJ3hX+mgVspUr6+PaIBZ1O//VHvgexn1q2ZDklYlx3RoJ44tmUpkaTy2xUwsa0KfjAZe6emIamQIjPeEky/c6/iaU9lkTRgXfoa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072280; c=relaxed/simple;
	bh=HnpGtnRbnZM4AM/ENNwGiaWU5/n9HHmzlea3vnt2Eao=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=RUlDiEvhPByVXQfbAwIjCQkXA79WaV4kXSTOhq0f/yEpydxuCrz6EV6pky5azh1N/p4dOqiiQhJkVSmPGjNP0mpsew/F8RDTUfVg6SiGjjeQyDGUHk20d+UXydLFbEqYQRSV/yI0ByToaNjODfLPKvFgclcbzBM0fcW9yO+cDog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=gWBo/ZXP; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="gWBo/ZXP"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-853c07a76adso151296b3a.0
        for <linux-wpan@vger.kernel.org>; Thu, 10 Sep 2026 13:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789072277; cv=none;
        d=google.com; s=arc-20260327;
        b=IvawoKb928Q5F1XphDMFJzRBv51dNI/Xl100PEbQNkBCdqVYR5cw0LH6UcTT508Tum
         LWLGkYC0OH2XPjHGq2tb07QQvy7CgrcquDdHiuPJVxMLxzu6f7yyzGn+VPNxoWw7TdEZ
         cIwkefMvlr7+RiY5vCBpOz/WyRUD0pBT7vYQmS1UWwm5evP4FDNlnnusdk1ZRCd3SMX3
         PtXMLQw/tOt62R09S7eDqiGEVbpQg8aXUQyXC3UJGdfRXklcxtakzMMDplvSq20TMXZO
         3iSFTJ7cb0Y/jU+VFZx73s7ut2n+9F0bCEp7aRdCOGFcyheIOiWxvTcmHK14RDooInsD
         iacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        fh=ghQVvrcuDLYsCuw630odtE2tmuoqUWc1Y88KeoOZjHg=;
        b=pBp3fCsX4mtjYDUSezw52dI82pWvTC+Op5FscGcIhpHxxq4qN3EDUH4R4k+h9e8Rsz
         XlF6wbPpaYB5TulS06rPNKvk2M/5ND3B3DQaC5Q4MZUpEkzpbhd3efzWxTlKY7pltiNg
         ViBSuF7Beh7e9UsHeHzXLmhsNug1ILBxourM96VDnctq+xd1e4Y4JdFtcCLxhiXqRNbx
         PMRMwRLVACvUKGYDp79nAZwV0hlmbgdcXB23KrznaXuf3cBru7BSoWWhMPEXjX1OuIiR
         o+qhYLU22H+hpU6WKMQWw+ZYoBoEGeJ4agyZHX/cJs039iZy1L+QjHiVD9z5u3y8UefU
         TuHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789072277; x=1789677077; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        b=gWBo/ZXPT4YZik/B+Jrmlb2U1l6J+wYXZZoaJDOG8Bn3Jgtf29X7Wyu43Adr3JDxrW
         veyxYkuPxigA0wYCWvFgvq1x9kg7uApW5OqFhijdUD/JNxROj6JZ+1FLUJS+HTOUQid6
         ke19X7blz4r5bqBC3IM41a8yXKRU2xlqMl0o/5SB7inuvrAu27CoXUCo6BP1kXXYh7zW
         x0JpnVCy20WRGC7GkoazdeuY/Mo2Y4b5EJlypHXHQyRE2mub+tE9qTwpNU6Pa8hgPUCs
         j3cNCEQL//dQnnCFSyXRsJ55hXPliYPCdeH6WDlXHKu9sUaALMSEJLpvmlfHD9+5inG/
         Xm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072277; x=1789677077;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=maCUZCHQL/0Dung/jQglQrSJpIrbe49RGrAjwhWAl9E=;
        b=VHCERVGhYQY2zNw78/ZzxAEW6JNgKdUxue7FlpRVctmHNfN3OWQlxFZsxKwraJB9VS
         DyBcYG5HCnnojQ9E1cCSn3PhvqKMf+Dqgj0PV3nTqiZuZDHnjCyc3wp8MfYD6wVICp/b
         4XDB9AyLHW4Wztjkk0TUNr+vjFh/FnNUMMb7q0oPeUKgKlhUIjbRAh6RS4d69RTFbm3S
         dVn2cdHBluuqHRc6JpfKqKO/i5PvFqmkSubzVrc5BiSHPvRZPlwddulk/J+ZJrtdwjqg
         MbhG2GvJ4r25P2rlIDlDIwJjdXKv72zR9ft6ldE3MLdkb6R8DZhfSthlrmrwYLS/9J7+
         CKhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsWyrLuHneXeRwW49vW7I5XwBWwHO0jR7pJvamulZzTV1a2HIF5p68G47waEhdPdaM+J6c8+DbAWfo@vger.kernel.org
X-Gm-Message-State: AFuF++mKP01qE4fxyk9dfZuBSDfaHNROC9w7oJLVWR7k606DaRrUVaTw
	dk+TyQP14otNR8xtYxpB8TXNGOP5MFeX4MVIVHJ9PbW5Wx+xqXVcXd2eVwL+CBRQ9Kkyxm6yAux
	GcRQ4ZzD8eijEkbQjNwyEPj24tEWtr/yvmudPRgxs
X-Gm-Gg: AYBFou2AxhEW2dqixVOUG1NOphidnC1i6Wzy0Z1ptfMFhAPAa9Vk7r4kyUmVO47rXC3
	71NQJ+u58lEAXfpz2BSY/q+JUoesLBxyIM7bnfRekSSFm1STYUCXLH3MkVZQahPlGwFItwplbyB
	L8+WIi3fXGdPYP/DDXOFuNU3hsMC6NpkoU/iKuDhC+XUWDCr6VIn2yheLRdBfviUlx4OVSUfZRl
	Itq7S/dmXDo54r5THZ8JOkIoaOojfTqSneNH6H58EKBurIEK38IiUiootEEmiCC72bXHDKyxiY3
	lwxq/FyVRQ3PoNnNd22sbkFmJqL11RuATiMlG1+MIZaSpI9owqgxq3L7PTQT1zXn7Lc1mbYgF3K
	6hqY1rDLmLz85clQR6WhCagovU/CJHJqfe2qFqVi7ZeE=
X-Received: by 2002:a05:6a00:981:b0:861:2029:4f59 with SMTP id
 d2e1a72fcca58-86b2eaf0dd9mr981631b3a.3.1789072275873; Thu, 10 Sep 2026
 13:31:15 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 20:31:14 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 20:31:14 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 20:31:14 +0000
X-Gm-Features: AcwNN1VUXzs2Scd6J6vqkMNAsWPmubZx5Syf8DU19mCYgSWymDz_57w_RDyC_Fc
Message-ID: <CA+0ovCgMrVBnn+0d198i0th0bcr0EAwNZ=0juh1ug8DdJX5mPw@mail.gmail.com>
Subject: [PATCH] 6lowpan: do not compress headers that are not fully present
To: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>, falemi@asu.edu, 
	Simon Horman <horms@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

lowpan_header_compress() pays for the IPHC header it pushes by first
calling skb_pull(skb, sizeof(struct ipv6hdr)), but that pull is a no-op
when skb->len is shorter than an IPv6 header, so the unpaid skb_push() can
drive skb->data below skb->head and into skb_under_panic().
lowpan_nhc_check_compression() has the same missing length check,
committing to the next-header compression path without requiring the
nhc->nexthdrlen transport bytes that nhc->compress() reads and
lowpan_nhc_do_compression() then pulls.  Return -EINVAL from
lowpan_header_compress() when pskb_may_pull() cannot produce a full IPv6
header, and return -ENOENT from lowpan_nhc_check_compression() unless the
IPv6 header plus nhc->nexthdrlen bytes are present, so that the nexthdr
falls back to its inline encoding.

Closes: https://lore.kernel.org/all/CA+0ovCjTsygN76s2o=TZqPqW8v2gBhmRnz+q6G-NaB3Cq-YPqQ@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -1140,6 +1140,10 @@ int lowpan_header_compress(struct sk_buff *skb,
const struct net_device *dev,
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;

+	/* The IPHC header pushed below is paid for by pulling this header. */
+	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+		return -EINVAL;
+
 	hdr = ipv6_hdr(skb);
 	hc_ptr = head + 2;

--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -47,7 +47,9 @@ int lowpan_nhc_check_compression(struct sk_buff *skb,
 	spin_lock_bh(&lowpan_nhc_lock);

 	nhc = lowpan_nexthdr_nhcs[hdr->nexthdr];
-	if (!(nhc && nhc->compress))
+	/* nhc->compress() reads and then pulls nexthdrlen transport bytes. */
+	if (!(nhc && nhc->compress) ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + nhc->nexthdrlen))
 		ret = -ENOENT;

 	spin_unlock_bh(&lowpan_nhc_lock);
