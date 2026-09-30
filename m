Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BF448CF3
	for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2026 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752759; cv=none; b=oujGtdYCJuM8DrtJ/CwdmIQVaqFIDRuxbydkCx6QFyRmGFzJHd5UNJtRbkgv7a8nZDQ0sCU5FdG95SZFEo/3lG/bmHtCy6Ml3PBvv8Poes/PE4xClgfBARJ36f7xCfQN5YSu1GsrA13SE2xnrSwl+/O/HvPVYRohnhZaVqwDQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752759; c=relaxed/simple;
	bh=PA4WHdZL97fHMVeMYVBzQqDhDDVdPEHyHKSQZGzkDpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8jlaWnxZcB08pSBxtKUTGRyZda3NngZyfKYtd7WOL5F3PvdpWucnvAbMarqr6biyVKl+aHnpAzUvZhSGKCM9B88kzrQbBC0IZSmTZrJn0UQ/yRNTFIUWiJ+jnH8ZtjkyS1AaEHwsty38yX+qqr9QKfGQmtmlQcI7DcV+cBM+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU/1ccAX; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU/1ccAX"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24afso2588176a91.3
        for <linux-wpan@vger.kernel.org>; Wed, 30 Sep 2026 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752756; x=1791357556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lD/BJV6m0Rx8++xUr7O227okZULoxqZpRvzaX7SrdP4=;
        b=PU/1ccAX2wnfBfYNV7QiAHAcwWVm8CzwDwlUvtIJkRiBaevk6yOCrqG8wKrNuALx4z
         tKNwM4zFzntnrngjGhmuH1MSV82UiRU42+cioTZdAX+isold7gKy9pm0tre5tjI8cRoj
         +fnvlTH+iU48bqid37aHYym6CQDUoBeSmRK4E6LpBpVe6odCDSrPohCS8S0fx5GVBNQh
         2ErDbQQw2s4eTCFb7HY9Qwk2trWAUKRQ5vtyjdQ4rApdrgW3Qkupz+0JBLFWFVZUXA65
         +lWp2vJRVTG2eJEWHjSOwwBNm3k3opOOWOxjWkwOZL3G1Fg96PPd0MsUbTtUaZMs5Us9
         qetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752756; x=1791357556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD/BJV6m0Rx8++xUr7O227okZULoxqZpRvzaX7SrdP4=;
        b=uwXzGXe0hMlkzyl3oVVMgfN5cV5Bv9Yj/J7+wkRjA+Y11M3YGBHz58rdkz2NM+ffOC
         nPEFfI/t09re6mlDj95Z+1c2UBUDN5jgGUIh18JNa0qBA9IZx2asmNRbj/ZXdghm78Bd
         rUH4u4hOTm6aH0T8AirjiD3W3b5jeJ/sUB9HJaCbyYZwi9+n55fiTKY+BygGRnN12Qk5
         cfjt0Lc4FNvYGAXg0oWi5UXEwWpLjfEvGH+dXzsZ+7WyegyJtGhvchf4+iCYl/SGHOBW
         NubV01XPX7mtaE8rh0NelX3Ide7eRHsrJw89p5MtvJQPQtPYWOtOsaYVYSBRG7T6ETC0
         A+Cw==
X-Forwarded-Encrypted: i=1; AKwUvBw+ZMp6b9tizLhYpSBt1c+PxAlmKhf9of4FrqjyrTlByMP27yIlJDSZGaQ+Id9DZTwwx9vDFAoiDbsq@vger.kernel.org
X-Gm-Message-State: AFq9FYJHwhd9yQzYX+gPheJhAR/6GirV9iDupfIVsAQwnsZRVD+D1ptr
	H49oGqJLtxM4a9BAl7+7HVf5nWPS+U0FJaGEWQTgAocgfFk63RwUt6he
X-Gm-Gg: AYBFou3IyvpirtR5oWQNg13OLaT+QA0YKq0F7RlprMLegFPhF1DlQDp+b4CdNzbl/qT
	qCdfHN8vsaWrM03JfqCUKDfJANXDcqJuSFGOjRsWrcKjwrRP/Firoohbmt4Ypzq98WHCu7rO5vk
	+ksyvc603Izda68RaRa8nNsvNXEZfZunrrQUYWhzU1j+20NwmGOEf5HiGCBxmQADfvEuiA9zBS9
	25Mp+783iQw6J0DwFO+ddrOSoSCMXFOmAVfOmyd9jJa+Afe4EMQxpQlUFDlVJ9CubpRcV++mML+
	iF77ZP1gqs9qiaWXNpwYDiwn10kJ8gQ7LSSQkoRrxhJhGJPOfXM/HT+1jbbE4NGqe+9NFCrnIQT
	zU2Z/8J/lP9gJtGMFDn8I9G/yKZIvWoH9/QgI+l/hMwdupAcxqzGZKFlGdDBlI0UKYNzE1rdUay
	n4qqhhKSb6KhNrM9MSpfVMbX8uel2ZZH2rFx8hd83wO5fLkiC5sFxu3QxLivGLc+zn94AwetsrQ
	Xq4ZzqXynzqt1UW1sP4j26aIBh4WF2iLplauYLirCGP8i0ViDov1oyf3eMSQAN/lcRs+/cIOErJ
	/VDg8CwGFVYNeLRP9VSIkw==
X-Received: by 2002:a17:90b:2250:b0:3a4:cfc2:354a with SMTP id 98e67ed59e1d1-3a4d1956b93mr255377a91.61.1790752756409;
        Wed, 30 Sep 2026 00:19:16 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4caec0f28sm2256687a91.17.2026.09.30.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:19:15 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 0/3] ieee802154: ca8210: fix stack and slab out-of-bounds accesses
Date: Wed, 30 Sep 2026 07:19:11 +0000
Message-ID: <20260930071914.421586-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three out-of-bounds access bugs in the Cascoda CA8210
IEEE 802.15.4 driver:

1. Reject received SPI packets with len > sizeof(struct mac_message) in
   ca8210_rx_done() instead of checking len > CA8210_SPI_BUF_SIZE (256),
   preventing a stack buffer overflow when copying a synchronous response
   into priv->sync_command_response (a struct mac_message on the caller's
   stack) and matching the actual SPI transfer length
   (cas_ctl->transfer.len = sizeof(struct mac_message)).
2. Initialize lenvar = 1 in ca8210_get_ed() and validate
   hw_attribute_length against *hw_attribute_length in
   hwme_get_request_sync() before memcpy() to prevent overflowing the
   caller's stack buffer.
3. Validate the received SPI frame length len upfront at the start of
   ca8210_skb_rx() before reading data_ind or allocating the skb.

Changes in v3:
- Patch 1/3: Check len > sizeof(struct mac_message) in ca8210_rx_done()
  where dev_crit() logs "Received packet len (%u) erroneously long" and
  drops the packet, instead of silently truncating the memcpy() with
  min_t(), addressing David Laight's feedback.

Changes in v2:
- Split the ca8210 fixes into three single-issue patches (1/3..3/3) and
  addressed Miquel Raynal's review comments on patches 2/3 and 3/3.

Hui Peng (3):
  ieee802154: ca8210: prevent stack buffer overflow in ca8210_rx_done()
  ieee802154: ca8210: prevent stack buffer overflow in
    hwme_get_request_sync()
  ieee802154: ca8210: validate data_ind length upfront in
    ca8210_skb_rx()

 drivers/net/ieee802154/ca8210.c | 39 +++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 12 deletions(-)

-- 
2.49.0
