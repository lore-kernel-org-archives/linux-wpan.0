Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292ED14F135
	for <linux-wpan@vger.kernel.org>; Fri, 10 Jan 2025 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494063; cv=none; b=EsGPgY5HK6cNGgH6O2BxU6FuBAm7/couGxNmX8H25n4ETIMvLnQNuucHIxaPBCi0+CyV3/Tm5AYyL41zR7QDlARVbkQMbVTRtKrmLibxeZ9HT4h+vtJ6iuBmmmmkEvb6L8rz4zn3/xhhe7dadSud2Y2SgSJcp06BdTKC0FGMUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494063; c=relaxed/simple;
	bh=s/WMDV0UKuDMM33XrDyTf0BUHN/EQR8KSDiCIeWeWFw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mDtPdWTrjYG54e+v88aGiWTkz3vy3EqTITkY52kh+HybL0Xi6B7XYg4em0NE1EkBqRS3u5wGOyqTMt8SEGSDwObyOs0Vxp1DBFT8lX4n/eIGC/YWXJfetqafizhJkGqzXJH3bF+aJR/eqO0Ak+he7/cuU66I9ABerAFE5y7dRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=BlCGSQA6; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="BlCGSQA6"
Received: from [192.168.2.30] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 6C1DAC0AE4
	for <linux-wpan@vger.kernel.org>; Fri, 10 Jan 2025 08:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1736494048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=80OWzUhSJRf4RwmKavi9edH/1LW/yQYvP85Q06LkFRk=;
	b=BlCGSQA6OhwDwkSKmyhEngodDckYckq9X7q5ehZcSVaczGKmQj5mefRBzCJuiWd0cYjTQa
	ObxBaww64C/UNLYB358V4jkkydlxE1uYSMb4dA8AI1DR4m+pSlNykI3W6IwjwO1Fb3b9Jq
	Ey3JwBFbidW4qKhlHncSVk9/uvrp2YTWhSIYOZhSCwkPy3Wm0RAHQ1KxfFoaIkQABvVTLd
	Vm/dK3+djZJ2Y/Pn5McgvTcgveRH78XvJSlUDsgmlS4zO/xfLnfbKtgKXdpldlSUXFlLyf
	xNK3rJh9hIokhe48FE5dQqafWja+nbJX3CL/TWIW/66l/fPMS0idKeCZSNmZUw==
Message-ID: <9736f9d4-1544-4865-882a-c91941baa7f2@datenfreihafen.org>
Date: Fri, 10 Jan 2025 08:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: wpan-tools 0.10 release
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

https://github.com/linux-wpan/wpan-tools/releases/tag/wpan-tools-0.10

It is a pleasure to announce the 0.10 release of wpan-tools.
Thanks to David Girault, Miquel Raynal and Romuald Despres for their 
contributions.

This release has been long in the making, but it also contains 
significant new features which has been developed on the kernel side.
Support for scanning, beaconing and associations have been added! This 
is a big step forward to allow running a full PAN coordinator on Linux.

In addition some usual maintenance work has been done. Notable is the 
move from TravisCI to GitHub actions, the addition of SPDX headers and 
reuse compliance.

David Girault (5):
iwpan: Export iwpan_debug
iwpan: Remove duplicated SECTION
iwpan: Add scan support
iwpan: Add events support
iwpan: Add beaconing support

Miquel Raynal (7):
iwpan: Synchronize nl802154.h with the latest kernel
iwpan: Fix a comment
iwpan: Synchronize nl802154.h with the latest scan changes
iwpan: Synchronize nl802154.h with the latest beaconing changes
iwpan: Allow the phy shortcut for scanning commands
iwpan: Synchronize nl802154.h with the latest association changes
iwpan: Add associations support

Romuald Despres (1):
iwpan: Fix the channels printing

Stefan Schmidt (14):
workflow: migrate from Travis CI to GitHub actions
m4: remove empty folder which only holds a .gitignore file
license: clearly indicate license in file name and use new LICENSES folder
wpan-ping: switch files to SPDX header for license and copyright
wpan-hwsim: switch files to SPDX header for license and copyright
src/nl802154.h: switch file to SPDX header for license and copyright
examples: switch files to SPDX header for license and copyright
src: switch files to SPDX header for license and copyright
misc: switch remaining files to SPDX header for license and copyright
workflow: add reuse job to check for REUSE compliance
workflow/main.yml: extend compile job to use matrix for gcc and clang
workflow/main.yml: extend matrix compile job to handle old Ubuntu LTS
workflow/main.yml: integrate reuse job into main workflow
Release 0.10
