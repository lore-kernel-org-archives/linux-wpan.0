Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34BF17C21E;
	Thu, 16 Oct 2025 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760587170; cv=none; b=VtadzqHm5hSVHCDznLEEn5JFzMoHdnrkg5R04UDHiktTr4v6WBE6W4weUOYFU/toYV2IZMOewXMvvYGkD+gmBwxd5t/X6DKg3hUdJxY6M7mJLwMTzreyo+tsHiDthIEcLu/mR1Xv9jio1wksH6O0ddChItA//JmnaD96LJczX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760587170; c=relaxed/simple;
	bh=GSjiZs2jK7JLhhRBvtztNh4JDHub51fZzPSRYqjNgaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNYnFersJ2OVB711GR5o5bHnFkXxI4gvVUMpbdvFZ/ynf8TvLV512UY++6UWhwUJAl3olHhBpwIMjW+ImH7qsLEWUhX8dnNkqQVHNPjnY2iUwIDJtVe2eNMuGvYS7+j2tUks4DPh28OrVFUC2KL9+N/TJ8CSBhIlrx0/RBkRruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GeenJvbP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GeenJvbP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=z67Ny9CzKjAZTdLksHZL+pvAg4dUyqchlFRNfVDAkzI=; b=GeenJvbPDmrB3uj8ZNbUilMpsm
	YzwtBrqo1GivN6CsT92DHO1ewRI/jqRvxfYxN10Dorbj/p0jhX0unk2wpJrYeYcrMApD745scRAcD
	oTsasknUOAeGiz2N+pU3hOg0jjSOFAdfI3CKKbzSYjj/W1+49jBYB0eIRbnFqB+NA3t3Z6L6sV6JB
	yiF7cv+pGD9uFhISlhAiAlvj2ptuuwFTFenW/cyaXCEdttmq1+1JAz4O7bis2HPqNnVIkDETa80+1
	rw4Pyn1hlqGmtGv0tDxGwWNN4kH0Up8VhB+wU7gDmqr8pH+lIWXAA9UuYMkvFBW9ZJav2j+ypTSBz
	hxJm5bgA==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9F98-0000000DVL6-1nbb;
	Thu, 16 Oct 2025 03:59:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-wpan@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH] nl802154: fix some kernel-doc warnings
Date: Wed, 15 Oct 2025 20:59:17 -0700
Message-ID: <20251016035917.1148012-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct multiple kernel-doc warnings in nl802154.h:

- Fix a typo on one enum name to avoid a kernel-doc warning.
- Drop 2 enum descriptions that are no longer needed.
- Mark 2 internal enums as "private:" so that kernel-doc is not needed
  for them.

Warning: nl802154.h:239 Enum value 'NL802154_CAP_ATTR_MAX_MAXBE' not described in enum 'nl802154_wpan_phy_capability_attr'
Warning: nl802154.h:239 Excess enum value '%NL802154_CAP_ATTR_MIN_CCA_ED_LEVEL' description in 'nl802154_wpan_phy_capability_attr'
Warning: nl802154.h:239 Excess enum value '%NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL' description in 'nl802154_wpan_phy_capability_attr'
Warning: nl802154.h:369 Enum value '__NL802154_CCA_OPT_ATTR_AFTER_LAST' not described in enum 'nl802154_cca_opts'
Warning: nl802154.h:369 Enum value 'NL802154_CCA_OPT_ATTR_MAX' not described in enum 'nl802154_cca_opts'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
---
 include/net/nl802154.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-next-20251013.orig/include/net/nl802154.h
+++ linux-next-20251013/include/net/nl802154.h
@@ -191,14 +191,12 @@ enum nl802154_iftype {
  * @NL802154_CAP_ATTR_CHANNELS: a nested attribute for nl802154_channel_attr
  * @NL802154_CAP_ATTR_TX_POWERS: a nested attribute for
  *	nl802154_wpan_phy_tx_power
- * @NL802154_CAP_ATTR_MIN_CCA_ED_LEVEL: minimum value for cca_ed_level
- * @NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL: maximum value for cca_ed_level
  * @NL802154_CAP_ATTR_CCA_MODES: nl802154_cca_modes flags
  * @NL802154_CAP_ATTR_CCA_OPTS: nl802154_cca_opts flags
  * @NL802154_CAP_ATTR_MIN_MINBE: minimum of minbe value
  * @NL802154_CAP_ATTR_MAX_MINBE: maximum of minbe value
  * @NL802154_CAP_ATTR_MIN_MAXBE: minimum of maxbe value
- * @NL802154_CAP_ATTR_MAX_MINBE: maximum of maxbe value
+ * @NL802154_CAP_ATTR_MAX_MAXBE: maximum of maxbe value
  * @NL802154_CAP_ATTR_MIN_CSMA_BACKOFFS: minimum of csma backoff value
  * @NL802154_CAP_ATTR_MAX_CSMA_BACKOFFS: maximum of csma backoffs value
  * @NL802154_CAP_ATTR_MIN_FRAME_RETRIES: minimum of frame retries value
@@ -364,6 +362,7 @@ enum nl802154_cca_opts {
 	NL802154_CCA_OPT_ENERGY_CARRIER_AND,
 	NL802154_CCA_OPT_ENERGY_CARRIER_OR,
 
+	/* private: */
 	/* keep last */
 	__NL802154_CCA_OPT_ATTR_AFTER_LAST,
 	NL802154_CCA_OPT_ATTR_MAX = __NL802154_CCA_OPT_ATTR_AFTER_LAST - 1
