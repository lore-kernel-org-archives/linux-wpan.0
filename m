Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480602;
	b=l7Zdi1ksJfTbvCTj4F/UlupIcDAFQ1PoWWfQ0rgwlFZY1SfuJK6ZOXrdeHzLrlaK6AR4
	 pakMmc0nR8QS3YUVC3IYT2AD/LqrSaFdkrYYUNkX3nZTbycM9YnsY7U8PWufH1Q3EMa0N
	 aIdYgtTBempgwoY4/Qrrza++rjwQ2T2CTmQHwYnoRveK+wikQXc9UEObIPSG5WRQB0gdF
	 LkFehMBdgxEa+3RiSCPDud0PLwt9nN/1H77Q7hiYHwYbqDy3JPrCKNitNhdc/ThS7JdIa
	 LErtnFU1VApCY01YVaupI1hM7yeEhF+vVqKk1Pey2BbVCcP8lBrODviuCp2vYAu4qUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CDcVH90vElOma+PIBRsVBwzcSu6I/4oFPmDU468ryv8=;
	b=nyK5rWBeF5hWVRrCJQqESZWgiSuEfrM/hqiZKzZz4KYe1Y2Wmlc5v/rGa5bXjFgGy7bI
	 v/HW3QWdUyinP5/6PXBjdi4kYqWQ5HVQ11zKgK5XbsGK6mNOP7ZLGJBD0CKQjPy1tovJw
	 8W2YyVVI/PkJJgrUOvGdBhRNLFAaAL6GgQwcIUlqf68zbBHdO8y359SdZpAdzSWylJbDT
	 6b/tZAEWMUphzdbN9qe2lxA0qrgttFHjefmiwLSeY6OS/a83u0H+dfI7gMEOh7cX7a/4P
	 cJXGG4Pu0C/5lrVpG0Ebr4nfA+fBoO5oyq7MdYxyurnd3lii4e2l7SlLOLdOj/FDKeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nvX+fDOL;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B953606A31B
	for <linux-wpan@vger.kernel.org>; Tue, 20 Oct 2026 07:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B953606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nvX+fDOL
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-354ba08cfd1so5295557eec.1
        for <linux-wpan@vger.kernel.org>; Tue, 20 Oct 2026 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792480601; x=1793085401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CDcVH90vElOma+PIBRsVBwzcSu6I/4oFPmDU468ryv8=;
        b=nvX+fDOLVa8EIMURVKrdikuXBiDAj7FaY2/kaDslST+SgmSmMyJZ/OKks8Wm6q0e2K
         n2UCBxa2OBIpkW9eD+sPxrkOsTYBsEZwjCpko3fGQy9HwjvUXhQI4H+QvMDwX38Z+1FE
         63oKwQqCeR3ssCuntXa7ZwS0nZX6ExPIzim3T+iX8ehbg8gCZleSMCoPNcySejxweVeM
         hF6gmRvSLMvJr2rE7UcyuKRdkXc9Jmbo7J/f0hpm/Mctd6J8uXomXjBPiRA8nWtBWeUB
         j6vuAcrexOmKfs+ODomSPrf90w57xSnsEdgn2hHPpw7Vk+NUnpL7Yof6c2Utx4B5xwqH
         xs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480601; x=1793085401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CDcVH90vElOma+PIBRsVBwzcSu6I/4oFPmDU468ryv8=;
        b=qzgJeFDVp6w8lqOfd1H/8EWY6vfvMgjGG2Vxjhp8E6pCnOAey3nuGAQlZJMtvZaCcz
         cFHqymc3LWpU3Dd7n37B7hh4dOa7/ZlmeJNiezHrIo0OyiLKr5kQtu3mI+WGbnUChJWB
         fqc9k7EjXtj7Kaxs75UvSeaAZHxnKpAFUdogcMwA9g+zz4lFFW+LkO74uCvvpB5oMrNW
         U8svfzpukp9b4RsyMK58cRegxfRoWiskcvXrjZacCSrrbbDDmphQAExu8085tnCP/bhQ
         0Kikg+Y9KasUzHhKwby2RshCsBNMDWLaojV1miyJmYzFYaYgTM0tFHrkISPJCBI+rYFA
         yJow==
X-Forwarded-Encrypted: i=1; AKwUvBwLfX38CykGgWPrfYrFpFCPOYS3ti8kLFfuYBeWKYDCN0KRsVbW207kLHAr4I63fF7LmdOw557bdZG7@vger.kernel.org
X-Gm-Message-State: AFq9FYLNimEOIXNdGmnaUWl1kAMNJB9OEvLKpZQg/Pqwz5sheNBar6rj
	G4Eqauc7gqxjD0Pzc08DdssAN4l3tB3C3bDY3+ZmGcT0knxUDbhPuazO
X-Gm-Gg: AYBFou3ieu5K0mh0jqQDDmeKZFPXojZAD9d+AuKoyVBH3MofWCQvmGwcSFHDP/tDY4E
	P5jeIXJXdyebBwOoACLloi2+p01wL4AXCq61GBkpSeGIbeCBIp0qZcWwOcIQ2DfVj1qX/ERs3PT
	smt1XjJdKKElFzXq+XFyi+Hs3tAU4VIK90Gna8h6h5eaVkVeXzkYqYqqqzDJBdRKckijpKM8gzF
	ls/2Q7Rj+23y6AFNL+1yaCH+J2srrCPdcvC9xdlK9lyaRDOfQZtteezxVVkOpULTeBNMqJ8KmBn
	mIrQ/yh1uul1venQUAsaI6lsJo30rf0RBquwVfndm/P1/FLQfc2Py4VPKB6Qu1zXelW55Ql1u13
	dlYHYYiR8dfBaLhDojciqWEzKJRj8TGO92095a8aqDM9SHe93H77yfClnuZgSHpKDf3MUQgQk2p
	c2sOSyQa5QWIWPCOj+LlchmFYk5NMMqEEjt6EhlIwrJRTYso3RMdWmJfxpgabHoBJkHa6hKUlQ4
	6Osr6bjBR4hMbuJXCJ7ZE8=
X-Received: by 2002:a05:693c:26c7:b0:35c:ef18:6a78 with SMTP id 5a478bee46e88-3619e925f33mr14707122eec.2.1792480601447;
        Tue, 20 Oct 2026 00:16:41 -0700 (PDT)
Received: from CHANDRUS-NITRO.localdomain ([106.200.8.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608219f838sm38434543eec.19.2026.10.20.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:16:41 -0700 (PDT)
From: Chandru Gopi <chandru.gopi.dev@gmail.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: maoyixie.tju@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	marcel@holtmann.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chandru Gopi <chandru.gopi.dev@gmail.com>
Subject: Re: [PATCH wpan] ieee802154: look up the wpan_phy dump ifindex in the caller's netns
Date: Tue, 20 Oct 2026 07:20:44 +0000
Message-ID: <20261020072044.4971-1-chandru.gopi.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020065125.896530-1-maoyixie.tju@gmail.com>
References: <20261020065125.896530-1-maoyixie.tju@gmail.com>
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Post: <mailto:linux-wpan@vger.kernel.org>
List-Help: <mailto:linux-wpan+help@vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-wpan+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on v7.3-rc7 (58161ead29e5) with the one-line change from this
patch applied, in x86_64 QEMU with two mac802154_hwsim radios. phy1 is
moved into a new netns and NL802154_CMD_GET_WPAN_PHY dumps are
requested from inside it. This covers the first two rows of your table:

                                         before       with change
  ifindex of own wpan1                   ENODEV       1 phy
  ifindex of init_net wpan0              empty dump   ENODEV

The unfiltered dump and the init_net baseline are unchanged. No
warnings were printed during the netns move. I did not test the
non-wpan ifindex case or the unprivileged user cases.

Tested-by: Chandru Gopi <chandru.gopi.dev@gmail.com>
