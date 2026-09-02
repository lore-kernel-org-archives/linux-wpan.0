Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10477371D14;
	Wed,  2 Sep 2026 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334000; cv=none; b=k2DCTlWhbuw6x9UBPTAJkkt4xoBCFR7YoFv8BkIVb3pKDD5A0tjADJZCMohaKKlOBcqDZoERlD4wKCdGaB4f1YHEA72TIP81En4JzfoEzQtqvnJCX/GBzqLfqbrJ+mWyaSxUoHVThieWcPJmvb6orYJp9Yv/ZpsqOJFLX+VLMkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334000; c=relaxed/simple;
	bh=odHtVUGTcuGSAqv/7fStxNyQ2gRG9pvDVbbQFaKZqFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCMX5z++TSQ4nRCjEoFHyPF0R6yJSquuwUVYEy+QZXZ2RrQ1htZxgmiLkr6E6DvJ++AY1lnxR3r4zRTen470u9rdejo7/ed0zPnTACtr+DnV9nQZLGg95ZrmwoayQr6pxNCUzjz/xFLvnux3oHiye1x6bIY1Wqwsb/YIEVeAoK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from work.datenfreihafen.local (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 7D3D4C0182;
	Wed,  2 Sep 2026 09:17:48 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	horms@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net] net: 6lowpan: fix mismatched comments
Date: Wed,  2 Sep 2026 09:17:29 +0200
Message-ID: <178833331770.3345487.12316333234810013405.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806091045.1701326-1-chenguang.zhao@linux.dev>
References: <20260806091045.1701326-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello Chenguang Zhao.

On Thu, 06 Aug 2026 17:10:45 +0800, Chenguang Zhao wrote:
> Rename @_nexthdrlen to @_hdrlen and drop stale @nhc from
> lowpan_nhc_do_uncompression docs
> 
> 

Applied to wpan/wpan.git, thanks!

[1/1] net: 6lowpan: fix mismatched comments
      https://git.kernel.org/wpan/wpan/c/9012da455ab9

regards,
Stefan Schmidt
