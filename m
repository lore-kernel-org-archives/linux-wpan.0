Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8C192B84;
	Thu, 29 Aug 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947857; cv=none; b=SXlk8uzkAB8fRuOmVsC6cMuM9o8AFC6uJ8AgIk2WjCG8AExHhjGxhJjsoV13O9Pr8MhFoj76S9t0SdeT74/FsSxYa8gY6Ggd/u1fKbZSLRs0MjTmaDrt5HRPVILpUIYDaujMmjv6GWpUWRiiXuLx+XBIL7r64qUjTH+h2WbtHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947857; c=relaxed/simple;
	bh=ktIuWU2/2Nly3rZNxJnuyyL4Jpe/l5seUp2lbAw4sD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HB6oyelcmZVNjuG3JyfflRUW5JEVFNotFMVls1eZ2PnSbEtcn0vNLXTkvOaakydgzS4Kgoeh66yaHxouhoTRWdnSZjcuHdNtufDXejT6pXqPNBapQ7cWqZezndblOAbJCscUuSNQ9JXrvHfVEs1cPCyuMzUH5y49uSDKF+MQFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEDuyKWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEDuyKWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3284C4CEC2;
	Thu, 29 Aug 2024 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947857;
	bh=ktIuWU2/2Nly3rZNxJnuyyL4Jpe/l5seUp2lbAw4sD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SEDuyKWMDlFthhlr2SOshLS4FUBtWaA8mT6ssr2stmLTSjTBbam6CkHbmUCvhhf2B
	 IlhktazcYDpV60NZmNknkFrabL0V2ARR3MUBAFpiGfrLBYkzjaQdWpw9evGSGVUrqY
	 qZReqNC7H2Jnu1iflUwrqyIpLXuMkmbaNUJA7FaDfjv7fTJExemKhdRmNAPA+deph9
	 4UjIqwI0LS0/H46gEMsee7mOpjYHeIeuO200CVupQHijI8NlByUmPuLuM5mNvPK5eu
	 aShpIKaLJ9jAhEQKI1HkKpo2GsLdL9syc1hfR9OCNKNrxdPvkQo0dRz1O1uzC2nrGx
	 QAmOEl/KpFkMA==
From: Simon Horman <horms@kernel.org>
Date: Thu, 29 Aug 2024 17:10:49 +0100
Subject: [PATCH wpan-next 1/2] mac802154: Correct spelling in mac802154.h
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wpan-spell-v1-1-799d840e02c4@kernel.org>
References: <20240829-wpan-spell-v1-0-799d840e02c4@kernel.org>
In-Reply-To: <20240829-wpan-spell-v1-0-799d840e02c4@kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in mac802154.h.
As reported by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/mac802154.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 4a3a9de9da73..1b5488fa2ff0 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -140,7 +140,7 @@ enum ieee802154_hw_flags {
  *
  * xmit_sync:
  *	  Handler that 802.15.4 module calls for each transmitted frame.
- *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
+ *	  skb contains the buffer starting from the IEEE 802.15.4 header.
  *	  The low-level driver should send the frame based on available
  *	  configuration. This is called by a workqueue and useful for
  *	  synchronous 802.15.4 drivers.
@@ -152,7 +152,7 @@ enum ieee802154_hw_flags {
  *
  * xmit_async:
  *	  Handler that 802.15.4 module calls for each transmitted frame.
- *	  skb cntains the buffer starting from the IEEE 802.15.4 header.
+ *	  skb contains the buffer starting from the IEEE 802.15.4 header.
  *	  The low-level driver should send the frame based on available
  *	  configuration.
  *	  This function should return zero or negative errno.

-- 
2.45.2

