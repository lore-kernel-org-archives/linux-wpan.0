Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF5149C7A
	for <linux-wpan@vger.kernel.org>; Fri,  6 Sep 2024 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653368; cv=none; b=Ob8o0RwbzlFBQq4WQB5Gd4qSl7nOfcZ4btXldZXbXwPhq3b0adaIgmm3ewUO1Axwh5NZcHHcEbiCcVgnZbgmJjLqaC5h3YnTi3V6mpizqxiszanX4XgvRF7r7ozztLJ60e2xBsbdOIq/Qo+P667alMVIsNgNn7REekiTtTnT/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653368; c=relaxed/simple;
	bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=Rr2K2fUNyjrggMTL7fD+EI6Mvs93RBhZ9U4ax90w7q85ZDnBt8WAjolwyJbyVYFcqocwJGS1kfDoZ+LtgW9pNt+pjQm7ORxGEccZ5q9CI+jRC1shjNuAoYm/Bp+9rooOcGb9PrUYpBES27MK7cM0/EyMPFeeRZa1mOaH2oAJrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com; spf=fail smtp.mailfrom=dgtlrift.com; dkim=pass (2048-bit key) header.d=dgtlrift-com.20230601.gappssmtp.com header.i=@dgtlrift-com.20230601.gappssmtp.com header.b=BK4GAdxU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dgtlrift-com.20230601.gappssmtp.com header.i=@dgtlrift-com.20230601.gappssmtp.com header.b="BK4GAdxU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6d3f017f80eso21482377b3.1
        for <linux-wpan@vger.kernel.org>; Fri, 06 Sep 2024 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dgtlrift-com.20230601.gappssmtp.com; s=20230601; t=1725653363; x=1726258163; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
        b=BK4GAdxUPiCmQI1+kGtEyf6gE2IJDkbYVBFwBFvuLf8+3XtULRa4MfMuRZLD0zb/7T
         NoeMv9FayKt4gTMJfUT1KhfbruPNVh6RLDwYxT6WhSJyrDUyTfBLxSONHLGxajfx1qs4
         7jPavgcYJTCanHqHw4BCgAlGf9TIAiKlnYZM93Y7ASPuIIGn2UJrNKLLM3yYMn/m2glE
         aFJn6k6Uk1VJOvNIQuS2L63YailO8bAE58K1qCfCmrCpbhfS2bWKX4W0atkcfpakfDge
         sUlobmYLfWPp+r+GVUeRV4vJQDum/ZGUNuLSqMPxvHV+Deg7sgAFEv2oEYVNAXvmNvGZ
         gtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725653363; x=1726258163;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
        b=A3pBQdXKK98veAE5Wjx/ew9YiQvVHBxcF3/7QtlqU6CwSq2LqONgmrztad13yz/j30
         yNd8PAMbPHvxCSyxUVFpu/Cj6TwqSmuSjpd9dyUZidpDq6M/z2r/hhafpORXX++JtjBs
         OMpyR593AXyyDF0LIfb/YbR9+PbjtV3MmudASOrC2EGCbMo6GMHZ+c/ozRvcDK+Wrhx0
         hT7bc5CtSj9Z62M+S/rtbNFTM9Be6m4j9DgrU5PEsUV6ZuQ/RLhaEd7UlfF6a+pT4JBQ
         sjY6mb6FvflHHcVumHTW5JlVJU0njGUXbqVOsl03tQ05g5mWMLa02E2XMxwZLmUhy4cQ
         a0sg==
X-Gm-Message-State: AOJu0YwPSz9VblX9UkUMtXUmrNonXWRzN4UcUQOh09s1EdL7UAGjgXUD
	/KturMXfSYU8avidzzfWhBiG/Rya0ZBVYP7MqW5JTMpnWMGbluLkY8S4SjVtmB6ZO77KG5tX9No
	1GA==
X-Google-Smtp-Source: AGHT+IHf7LoakDJvaCLEfcQOLMt/PCD6T9tis+7EOusIRm5AzPRcoinXhWZbQrp/i1xId/R0Ba2BhA==
X-Received: by 2002:a05:690c:2f0a:b0:64a:7040:2d8e with SMTP id 00721157ae682-6db45154284mr36932147b3.33.1725653363110;
        Fri, 06 Sep 2024 13:09:23 -0700 (PDT)
Received: from smtpclient.apple ([148.80.254.66])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db56337757sm1230757b3.39.2024.09.06.13.09.22
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 13:09:22 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James Hanley <jhanley@dgtlrift.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 6 Sep 2024 16:09:11 -0400
Subject: Subscribe
Message-Id: <6B87A368-3A45-47F4-81FD-94330ED40B51@dgtlrift.com>
To: linux-wpan@vger.kernel.org
X-Mailer: iPhone Mail (21G93)

Subscribe


