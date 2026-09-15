Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09742BEAA
	for <linux-wpan@vger.kernel.org>; Tue, 15 Sep 2026 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448498; cv=none; b=hYyt5FwOTXh21ZQD404qdNouUuGqotZpOFN5pHMwxf04CW0N+LVgJt3MFav8fk9CpB3m/cix22hWMPOLTVmyXQEPE6sPkPLU9JhVhzJdqIY2B0JwXwRhLdSayJFr2YP9NpGZPu0wM3Qc+oiA4vbw+bUo13aWW3V+POR+qhlEwII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448498; c=relaxed/simple;
	bh=WvJDz0SMer3VBOphKTbusnWx9vBwOwyigPUnd+wAAiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AB97BGpUaJkimuI1Iz/25GiJa+CkRHzLJoadNFrwayrU3timh7yuX6LTHWm+GwhrnaddMtITVgtn/ys43so7E8zTbhPlnLl77EcKWLYR9alOlryq6OsP1ncBEtry36QuV5jfXf570qk3QSS+vgx50iCptLm48tWZvOHosWUsjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CESLyb8q; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CESLyb8q"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso2818698a91.3
        for <linux-wpan@vger.kernel.org>; Mon, 14 Sep 2026 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789448495; x=1790053295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ptBV0v6Gt6jAGsqstGkmrulpyxyqgfaikKMDt/h5aaw=;
        b=CESLyb8qb9mC71opDonoVuBQSmNLGkr0FyokxmGTXBXKnoGBaohfQtCFhF9iYDfSZX
         OfGYYFOzGxa4dsd6j/zDtS3Cj4a3AGa5Jgfo/pd75wLuIaRmJ60D350O2I53HL0JbM7Y
         SE4OMaXtERlI24QAe/wrufjpOkVXCuFppv5+fe5PKlShsccsf0EP2nRdjP+6sMye1e1i
         brCrnikbGHwPIZF0H5foqV7lrJ0oGAEgNgHtTVhR7uTwHOOmREhZUCnimhLJMchiBk6G
         w0hU0HuoY3ONKkoG5l27rBui5zgFaPh48lKsfBqYcAqTFfo24Z938eEoWWXxi/ZA7q8W
         EBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789448495; x=1790053295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ptBV0v6Gt6jAGsqstGkmrulpyxyqgfaikKMDt/h5aaw=;
        b=ZHMfNTYImn4BtpjVFEhQ9X8MieUG5MmBika4AwDGMcOVnHAuuJkYCrby/PAF3SCFkF
         OYmbg2pGIqF/Ln+mobGBMVHPXN3PFkO/sww2FpScweW27M70wEasoDWzGyUTQc2Swv/O
         /OJaoin73ZSCuZT2OBVXv4j6yGE1HrW++Z4w33+wNdlK8ty7RnRXEB38+oBUTVeKunFf
         UmZhzyHO6QY5A8fF+Zse21mtyt3yDSg7E7A0AkIl+UfFJ/4nVtKzsP9QLXURQ9NJQ0G1
         4Uo1Is8SIsVHfho+h1pax+QiiubznQBR5krIJBTv0OielLtk/NG1q0CmR5C6e9IJtkJ4
         vZoA==
X-Forwarded-Encrypted: i=1; AKwUvBxdZOvgRUQSOytOP+RNMTk3Nj4tEeMPdm7+3jVa2Qsr0qhHZUBjMUOrH68zLCdr0ELmRHvhryWqF6PU@vger.kernel.org
X-Gm-Message-State: AFuF++k/PtscmB0RkQqtLBpbZjasMe8guZULxfNvdCUAZTPGsbNBf5Df
	5x4u9nqzfFWrfJcOLYad0FfKjd06CArNwGLIsc9/UFtu8l4vvvRztqTP
X-Gm-Gg: AYBFou32nofYVIM1NFWLLuD+c5pQbXYFN/PPsjmS5njt9GgabwwPq74dcjWZyiCPF3E
	XQlWezhmJWJIvyGPDaa8846Wz1nk0kOYiwaq1U4PsnnfqDXEUAhiOsbtWczQp0v30GuVacSGv47
	K162MOnaugJfDFsfoWibmhPscE8QB1isIJtaoXnGZ1r6db4NJJ8orU2oRsyL2e6uxLtr4iP9wZg
	OYikfPxfCO/w0wJhIqBj6uOGxu7XonVB6hb9hqae4foyF4erJ3o0igXGHEX8f7yHCgI9p73DM9s
	+DCnH4DXsITV/F/HiXxJ3VOCfIXQ+xGTiKqvS1sT2WAPI2gSv0pbnHwZUPrAJmxn+EC9elRLmn4
	mcYkcaPt6QpJB5brGMGjAg7F2vH36l6A8G/+UyMI/saCsOj9uey9TnqnWCgthpejeGnMLt5UsfY
	h4ZQfs319ok+58XILEamQslJW5Do2IGv/9VRj6V6BisYgvL34rDowZLmzrHQ5s1XiCBdmmhAVPf
	MKnSx0Eo7aQv0fet7Jf45jt9kf8/2tXjn0GOBYdkRgiz9rOg2ywFO+N61hP9ivW3VgLRP/8fyY5
	JK9L6kXUNqD/eOsBqbbU
X-Received: by 2002:a17:90b:57cb:b0:39d:f130:f8fd with SMTP id 98e67ed59e1d1-39df13108cdmr11368757a91.11.1789448494978;
        Mon, 14 Sep 2026 22:01:34 -0700 (PDT)
Received: from lawlee-vm0.d4y3nv5wwgfelhhopdxv1tqjld.dx.internal.cloudapp.net ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e51449sm26872358eec.5.2026.09.14.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:01:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/2] ipv6: update NUD_FAILED neighbors from NA messages
Date: Tue, 15 Sep 2026 05:01:30 +0000
Message-ID: <cover.1789448374.git.lfqlee314@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neighbor Advertisements for existing NUD_FAILED entries are currently
ignored. This can leave a first-hop router with an unusable neighbor after
the host becomes reachable and announces itself, particularly when
forwarding is offloaded away from the kernel and traffic destined to the
FAILED neighbor is unable to trigger the kernel's normal neighbor
resolution process.
Allowing neighbor entries to be updated from NAs already received by the
kernel is preferable since it creates less work compared to periodically
probing FAILED neighbors (e.g. using NTF_EXT_MANAGED).

Extend accept_untracked_na to treat FAILED entries like absent entries.
Require a target link-layer address, IPv6 forwarding, and acceptance by the
sysctl, including its source-prefix check in mode 2. Recover the entry only
to STALE, including for solicited NAs, to maintain parity with handling of
non-existent neighbor cache entries.

Patch #1 implements the behavior and updates RFC 9131-related comments and
accept_untracked_na documentation.

Patch #2 extends ndisc_unsolicited_na_test.sh to cover FAILED-entry
recovery and each acceptance gate, including in-prefix and out-of-prefix
mode 2.

Thanks to Ido Schimmel for feedback on the original RFC.

---
v2:
- Full implementation of logic to update FAILED entries to STALE.
- Update the RFC 9131-related comments and sysctl documentation.
- Add selftests to verify state changes only when the accept_untracked_na
  setting is enabled.

v1 (RFC):
https://lore.kernel.org/r/20260813233344.445265-1-lfqlee314@gmail.com

Testing:
- x86_64 current-config and allyesconfig builds with W=1
- tools/testing/selftests/net/ndisc_unsolicited_na_test.sh: 14 passed
- Local NIPA checks: all substantive checks passed
- Sashiko local review completed

Lawrence Lee (2):
  ipv6: update NUD_FAILED neighbors from NA messages
  selftests: net: test untracked NA recovery of FAILED neighbors

 Documentation/networking/ip-sysctl.rst        |  28 ++--
 include/net/ndisc.h                           |  15 ++-
 net/6lowpan/ndisc.c                           |  15 ++-
 net/ipv6/ndisc.c                              |  94 ++++++++-----
 .../net/ndisc_unsolicited_na_test.sh          | 124 +++++++++++++++---
 5 files changed, 201 insertions(+), 75 deletions(-)


base-commit: 272a65db243bfa34b9277632830e0e06d7e3518e
-- 
2.43.0
